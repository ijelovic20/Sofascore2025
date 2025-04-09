import UIKit
import SofaAcademic

class ViewController: UIViewController, BaseViewProtocol, HeaderViewDelegate {
    private let menu = MenuView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let header = HeaderView()
    private var selectedSportName: String = "Football"

    var groupedEvents: [(league: League?, events: [Event])] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEvents(sport: selectedSportName.lowercased())
        
        menu.onSportSelected = { selectedSportName in
            var sportName = selectedSportName
            if sportName == "Am. Football" {
                sportName = "Am-football"
                self.selectedSportName = "Am. Football"
            } else {
                self.selectedSportName = sportName
            }
            self.fetchEvents(sport: sportName.lowercased())
        }

        header.delegate = self

        addViews()
        styleViews()
        setupConstraints()
    }

    private func fetchEvents(sport:String) {
        APIClient.fetchEvents(forSport: sport) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let events):
                        self.groupedEvents = Dictionary(grouping: events, by: { $0.league.id }).compactMap { (_, events) in
                            guard let league = events.first?.league else { return nil }
                            return (league, events)
                        }
                        self.tableView.reloadData()
                    case .failure(let error):
                        print("API error: \(error)")
                }
            }
        }
    }
    
    func addViews() {
        view.addSubview(header)
        view.addSubview(menu)
        view.addSubview(tableView)
    }

    func styleViews() {
        view.backgroundColor = .customBlue

        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = UITableView.automaticDimension

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.reuseIdentifier)
    }

    func setupConstraints() {
        header.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        menu.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(menu.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    // MARK: - HeaderViewDelegate
    func didTapSettings() {
        let settingsVC: SettingsViewController = .init()
        settingsVC.modalPresentationStyle = .fullScreen
        present(settingsVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedEvents.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedEvents[section].events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.reuseIdentifier, for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }

        let event = groupedEvents[indexPath.section].events[indexPath.row]
        cell.configure(with: EventViewModel(event: event))

        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let league = groupedEvents[section].league else { return nil }
        let header = LeagueView()
        header.configure(with: LeagueViewModel(league: league))
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        let event = groupedEvents[indexPath.section].events[indexPath.row]
        
        guard let league = groupedEvents[indexPath.section].league else {
            return
        }

        let leagueViewModel = LeagueViewModel(league: league)
        let eventViewModel = EventViewModel(event: event)

        let detailsVC = EventDetailsViewController(event: eventViewModel, league: leagueViewModel, sportName: selectedSportName)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
