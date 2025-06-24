import UIKit
import SofaAcademic
import Combine
import SnapKit

class TeamDetailViewController: UIViewController, BaseViewProtocol {
    private let headerViewModel: HeaderViewModel
    private let headerView = LeagueDetailView()
    private let tabMenu = MenuView<TeamTab>(
        items: TeamTab.allCases,
        titleProvider: { $0.rawValue }
    )
    private let detailsView = TeamDetailView()
    private let playersTableView = UITableView()

    private var manager: TeamManager?
    private var players: [Player] = []
    private var cancellables = Set<AnyCancellable>()
    private var tournaments: [League] = []

    init(headerViewModel: HeaderViewModel) {
        self.headerViewModel = headerViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setupConstraints()
        setupBindings()
        configureHeader()

        Task {
            await fetchTeamInfo()
            await fetchPlayers()
            await fetchTournaments()
        }
    }

    func addViews() {
        view.addSubview(headerView)
        view.addSubview(tabMenu)
        view.addSubview(detailsView)
        view.addSubview(playersTableView)

        playersTableView.register(PlayersCellView.self, forCellReuseIdentifier: "ManagerCellView")
        playersTableView.register(PlayersCellView.self, forCellReuseIdentifier: "PlayersCellView")
        playersTableView.dataSource = self
        playersTableView.delegate = self
        playersTableView.tableFooterView = UIView()

        detailsView.isHidden = false
        playersTableView.isHidden = true
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

        detailsView.snp.makeConstraints {
            $0.top.equalTo(tabMenu.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        playersTableView.snp.makeConstraints {
            $0.top.equalTo(tabMenu.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setupBindings() {
        headerView.backButtonTappedPublisher
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)

        tabMenu.onItemSelected = { [weak self] selectedTab in
            guard let self = self else { return }
            self.detailsView.isHidden = selectedTab != .details
            self.playersTableView.isHidden = selectedTab != .players
        }
    }

    private func configureHeader() {
        headerView.configure(with: headerViewModel)
    }

    private func fetchTeamInfo() async {
        guard let teamId = headerViewModel.teamId else {
            print("Team ID is nil")
            return
        }

        do {
            let teamInfo = try await APIClient.fetchTeamInfo(forTeamID: teamId)
            DispatchQueue.main.async { [weak self] in
                self?.manager = teamInfo.manager
                self?.detailsView.configure(with: teamInfo)
                self?.playersTableView.reloadData()
            }
        } catch {
            print("Failed to fetch team info: \(error.localizedDescription)")
        }
    }

    private func fetchPlayers() async {
        guard let teamId = headerViewModel.teamId else {
            print("Team ID is nil")
            return
        }

        do {
            let players = try await APIClient.fetchPlayers(forTeamId: teamId)
            DispatchQueue.main.async { [weak self] in
                self?.players = players
                let foreignPlayers = players.filter { $0.isForeign ?? true }
                self?.detailsView.setPlayerCount(players.count)
                self?.detailsView.setForeignPlayerRatio(foreignCount: foreignPlayers.count, total: players.count)
                self?.playersTableView.reloadData()
            }
        } catch {
            print("Failed to fetch players: \(error.localizedDescription)")
        }
    }

    private func fetchTournaments() async {
        guard let teamId = headerViewModel.teamId else {
            print("Team ID is nil")
            return
        }

        do {
            let tournaments = try await APIClient.fetchTournaments(forTeamId: teamId)
            DispatchQueue.main.async { [weak self] in
                self?.tournaments = tournaments
                self?.detailsView.configureTournaments(tournaments)
            }
        } catch {
            print("Failed to fetch tournaments: \(error.localizedDescription)")
        }
    }
}

// MARK: - Tabs
enum TeamTab: String, CaseIterable {
    case details = "Details"
    case players = "Players"
}

// MARK: - UITableViewDataSource & Delegate
extension TeamDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return manager != nil ? 1 : 0
        case 1:
            return players.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersCellView", for: indexPath) as! PlayersCellView

        switch indexPath.section {
        case 0:
            if let manager = manager {
                cell.configure(with: manager)
            }
        case 1:
            let player = players[indexPath.row]
            cell.configure(with: player)
        default:
            break
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let label = UILabel()
        label.font = .robotoBold12
        label.textColor = .customBlack
        label.text = section == 0 ? "Coach" : "Players"
        
        headerView.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(16)
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return manager != nil ? 40 : 0
        case 1:
            return players.isEmpty ? 0 : 40
        default:
            return 0
        }
    }
}
