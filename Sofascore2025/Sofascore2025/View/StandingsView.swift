import UIKit
import SnapKit
import SofaAcademic

class StandingsView: BaseView {
    private var headerLabels: [UILabel] = []
    private var headerTitles: [String] = []
    private var currentSport: Sport?
    private var standings: [Standing] = []
    let tableView = UITableView()

    override func addViews() {
        headerLabels.forEach { addSubview($0) }
        addSubview(tableView)
    }

    override func styleViews() {
        backgroundColor = .white
        headerLabels.forEach {
            $0.font = .robotoRegular14
            $0.textColor = .customBlackGray
            $0.adjustsFontSizeToFitWidth = true
            $0.textAlignment = .center
            headerLabels[1].textAlignment = .left
        }
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.contentInset = .zero
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.separatorStyle = .none
        tableView.register(StandingsTableViewCell.self, forCellReuseIdentifier: StandingsTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupConstraints() {
        guard headerLabels.count >= 2 else { return }

        headerLabels[0].snp.remakeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(24)
        }

        headerLabels[1].snp.remakeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(headerLabels[0].snp.trailing).offset(16)
            $0.height.equalTo(24)
            $0.width.greaterThanOrEqualTo(80)
        }
        
        var previousTrailingLabel: UILabel?

        for i in (2..<headerLabels.count).reversed() {
            let label = headerLabels[i]
            label.textAlignment = .center

            label.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(16)
                $0.height.equalTo(24)

                if let prev = previousTrailingLabel {
                    $0.trailing.equalTo(prev.snp.leading).offset(-8)
                    $0.width.greaterThanOrEqualTo(24)
                } else {
                    $0.trailing.equalToSuperview().inset(8)
                    $0.width.greaterThanOrEqualTo(40)
                }
            }
            previousTrailingLabel = label
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(headerLabels[0].snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func configureHeader(sport: Sport) {
        currentSport = sport

        switch sport {
        case .basketball:
            headerTitles = ["#", "Team", "P", "W", "L", "DIFF", "PCT"]
        case .americanFootball:
            headerTitles = ["#", "Team", "P", "W", "D", "L", "PCT"]
        default:
            headerTitles = ["#", "Team", "P", "W", "D", "L", "Goals", "PTS"]
        }

        headerLabels.forEach { $0.removeFromSuperview() }
        headerLabels.removeAll()

        for title in headerTitles {
            let label = UILabel()
            label.text = title
            headerLabels.append(label)
        }
        
        addViews()
        styleViews()
        setupConstraints()
    }

    func setStandings(_ data: [Standing], for sport: Sport) {
        self.standings = data
        self.currentSport = sport
        tableView.reloadData()
    }
}

extension StandingsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        standings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: StandingsTableViewCell.reuseIdentifier, for: indexPath) as? StandingsTableViewCell else {
            return UITableViewCell()
        }

        let standing = standings[indexPath.row]
        cell.configure(with: standing, sport: currentSport)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        32
    }
}
