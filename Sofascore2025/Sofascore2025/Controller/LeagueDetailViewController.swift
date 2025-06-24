import UIKit
import SofaAcademic
import Combine
import SnapKit

class LeagueDetailViewController: UIViewController, BaseViewProtocol {
    private let league: League
    private let selectedSport: Sport
    private let headerView = LeagueDetailView()
    private let tabMenu = MenuView<LeagueTab>(
        items: LeagueTab.allCases,
        titleProvider: { $0.rawValue }
    )

    private let matchesTableView = UITableView()
    private let standingsTableView = UITableView()
    private let standingsView = StandingsView()

    private var groupedEvents: [(key: Int, value: [Event])] = []
    private var standings: [Standing] = []
    private var cancellables = Set<AnyCancellable>()
    private var hasSetTableHeader = false

    init(league: League, selectedSport: Sport) {
        self.league = league
        self.selectedSport = selectedSport
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        setupBindings()
        setupTableViews()
        configureInitialState()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasSetTableHeader {
            setupStandingsTableHeader()
            hasSetTableHeader = true
        }
    }

    func addViews() {
        view.addSubview(headerView)
        view.addSubview(tabMenu)
        view.addSubview(matchesTableView)
        view.addSubview(standingsTableView)
    }

    func styleViews() {
        standingsTableView.isHidden = true
    }

    func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(180)
        }

        tabMenu.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        matchesTableView.snp.makeConstraints {
            $0.top.equalTo(tabMenu.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        standingsTableView.snp.makeConstraints {
            $0.top.equalTo(tabMenu.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setupBindings() {
        let headerViewModel = HeaderViewModel(
            teamId: nil,
            imageUrl: league.logoUrl,
            title: league.name,
            subtitle: league.country?.name ?? ""
        )
        headerView.configure(with: headerViewModel)

        headerView.backButtonTappedPublisher
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)

        tabMenu.onItemSelected = { [weak self] selectedTab in
            guard let self = self else { return }
            switch selectedTab {
            case .matches:
                self.standingsTableView.isHidden = true
                self.matchesTableView.isHidden = false
                self.fetchMatches()
            case .standings:
                self.matchesTableView.isHidden = true
                self.standingsTableView.isHidden = false
                self.fetchStandings()
            }
        }
    }

    func setupTableViews() {
        matchesTableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.reuseIdentifier)
        matchesTableView.dataSource = self
        matchesTableView.delegate = self
        matchesTableView.sectionHeaderTopPadding = 0

        standingsTableView.register(StandingsTableViewCell.self, forCellReuseIdentifier: StandingsTableViewCell.reuseIdentifier)
        standingsTableView.dataSource = self
        standingsTableView.delegate = self
        standingsTableView.tableFooterView = UIView()
    }

    func setupStandingsTableHeader() {
        standingsView.configureHeader(sport: selectedSport)

        let targetWidth = standingsTableView.bounds.width
        let targetHeight: CGFloat = 48

        standingsView.frame = CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight)
        standingsView.setNeedsLayout()
        standingsView.layoutIfNeeded()

        standingsTableView.tableHeaderView = standingsView
    }

    func configureInitialState() {
        standingsView.configureHeader(sport: selectedSport)
        setupStandingsTableHeader()
        fetchMatches()
    }

    func fetchMatches() {
        Task {
            do {
                let events = try await APIClient.fetchMatches(forLeagueId: league.id)
                let finishedEventsWithRound = events.filter { $0.status == .finished && $0.round != nil }
                let grouped = Dictionary(grouping: finishedEventsWithRound, by: { $0.round! })
                self.groupedEvents = grouped.sorted { $0.key < $1.key }

                DispatchQueue.main.async {
                    self.matchesTableView.reloadData()
                }
            } catch {
                print("error \(error)")
            }
        }
    }

    func fetchStandings() {
        Task {
            do {
                let standings = try await APIClient.fetchStandings(forLeagueId: league.id)
                DispatchQueue.main.async {
                    self.standings = standings
                    self.standingsTableView.reloadData()
                }
            } catch {
                print("Error fetching standings: \(error)")
            }
        }
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate

extension LeagueDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        tableView == standingsTableView ? 1 : groupedEvents.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView == standingsTableView ? standings.count : groupedEvents[section].value.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        tableView == standingsTableView ? nil : "Round \(groupedEvents[section].key)"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == standingsTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StandingsTableViewCell.reuseIdentifier, for: indexPath) as? StandingsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: standings[indexPath.row], sport: selectedSport)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.reuseIdentifier, for: indexPath) as? EventTableViewCell else {
                return UITableViewCell()
            }
            let event = groupedEvents[indexPath.section].value[indexPath.row]
            cell.configure(with: EventViewModel(event: event, dateInsteadOfTime: true))
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard tableView != standingsTableView else { return nil }

        let headerView = UIView()
        headerView.backgroundColor = .customBlueGray

        let label = UILabel()
        label.text = "Round \(groupedEvents[section].key)"
        label.textColor = .customBlack
        label.font = .robotoBold12

        headerView.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(8)
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView == standingsTableView ? 0 : 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == standingsTableView {
            let standing = standings[indexPath.row]
            
            let headerViewModel = HeaderViewModel(
                teamId: standing.team.id,
                imageUrl: standing.team.logoUrl,
                title: standing.team.name,
                subtitle: standing.team.country?.name ?? ""
            )
            
            let teamDetailVC = TeamDetailViewController(headerViewModel: headerViewModel)
            navigationController?.pushViewController(teamDetailVC, animated: true)
        }
    }
}
