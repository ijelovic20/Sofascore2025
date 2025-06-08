import UIKit
import SofaAcademic
import Combine
import SnapKit

class LeagueDetailViewController: UIViewController, BaseViewProtocol {
    private let league: League
    private let leagueDetailView: LeagueDetailView
    private let matchesTableView = UITableView()
    
    private var groupedEvents: [(key: Int, value: [Event])] = []
    private var cancellables = Set<AnyCancellable>()
    
    let tabMenu = MenuView<LeagueTab>(
        items: LeagueTab.allCases,
        titleProvider: { $0.rawValue }
    )

    init(league: League) {
        self.league = league
        self.leagueDetailView = LeagueDetailView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupConstraints()
        setupTableView()
        
        leagueDetailView.configure(league: league)
        
        leagueDetailView.backButtonTappedPublisher
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
        
        self.fetchMatches()
        
        tabMenu.onItemSelected = { [weak self] selectedTab in
            guard let self = self else { return }
            switch selectedTab {
            case .matches:
                self.fetchMatches()
            case .standings:
                print("standings")
            }
        }
    }
    
    func addViews() {
        view.addSubview(leagueDetailView)
        view.addSubview(tabMenu)
        view.addSubview(matchesTableView)
    }
    
    func setupConstraints() {
        leagueDetailView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            //$0.height.equalTo(180)
        }
        
        tabMenu.snp.makeConstraints {
            $0.top.equalTo(leagueDetailView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        matchesTableView.snp.makeConstraints {
            $0.top.equalTo(tabMenu.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupTableView() {
        matchesTableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.reuseIdentifier)
        matchesTableView.dataSource = self
        matchesTableView.delegate = self
        matchesTableView.sectionHeaderTopPadding = 0
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
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension LeagueDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedEvents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedEvents[section].value.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Round \(groupedEvents[section].key)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.reuseIdentifier, for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }

        let event = groupedEvents[indexPath.section].value[indexPath.row]
        let viewModel = EventViewModel(event: event, dateInsteadOfTime: true)
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .customBlueGray

        let label = UILabel()
        label.text = "Round \(groupedEvents[section].key)"
        label.textColor = .customBlack
        label.font = UIFont(name: "Roboto-Bold", size: 12) ?? UIFont.boldSystemFont(ofSize: 12)

        headerView.addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(8)
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
}
