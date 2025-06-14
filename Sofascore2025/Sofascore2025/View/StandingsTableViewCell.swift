import UIKit
import SnapKit
import SofaAcademic

class StandingsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "StandingsTableViewCell"

    private let circleView = UIView()
    private var labels: [UILabel] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        contentView.addSubview(circleView)
        circleView.layer.cornerRadius = 12
        circleView.clipsToBounds = true
        circleView.backgroundColor = .customYellowGreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with standing: Standing, sport: Sport?) {
        labels.forEach { $0.removeFromSuperview() }
        labels.removeAll()
        circleView.subviews.forEach { $0.removeFromSuperview() }

        guard let sport = sport else { return }

        var values: [String] = []

        switch sport {
        case .basketball:
            let diff = (standing.scoreFor ?? 0) - (standing.scoreAgainst ?? 0)
            let pct = standing.percentage.map { String(format: "%.3f", $0) } ?? "-"
            let streak = "-"
            let gb = "-"
            
            values = [
                "\(standing.position)",
                standing.team.name,
                "\(standing.matches)",
                "\(standing.wins)",
                "\(standing.losses)",
                "\(diff)",
                streak,
                gb,
                pct
            ]
        case .americanFootball:
            let pct = standing.percentage.map { String(format: "%.3f", $0) } ?? "-"
            values = [
                "\(standing.position)",
                standing.team.name,
                "\(standing.matches)",
                "\(standing.wins)",
                "\(standing.draws)",
                "\(standing.losses)",
                pct
            ]
        default:
            let goals = "\(standing.scoreFor ?? 0):\(standing.scoreAgainst ?? 0)"
            let pts = standing.points.map { "\($0)" } ?? "-"
            values = [
                "\(standing.position)",
                standing.team.name,
                "\(standing.matches)",
                "\(standing.wins)",
                "\(standing.draws)",
                "\(standing.losses)",
                goals,
                pts
            ]
        }

        for (index, value) in values.enumerated() {
            let label = UILabel()
            label.font = .robotoRegular14
            label.textColor = .customBlack
            label.text = value
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center

            labels.append(label)

            if index == 0 {
                circleView.addSubview(label)
            } else {
                contentView.addSubview(label)
            }
        }
        
        labels[1].textAlignment = .left

        var previousTrailingLabel: UILabel?

        for i in (2..<labels.count).reversed() {
            let label = labels[i]
            label.textAlignment = .center

            label.snp.makeConstraints {
                $0.centerY.equalToSuperview()

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
        setupConstraints()
    }

    private func setupConstraints() {
        guard labels.count >= 2 else { return }

        circleView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }

        labels[0].snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        labels[1].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(circleView.snp.trailing).offset(16)
            $0.width.greaterThanOrEqualTo(80)
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
