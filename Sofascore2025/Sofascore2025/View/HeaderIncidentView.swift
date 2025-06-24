import UIKit
import SnapKit
import SofaAcademic

final class HeaderIncidentView: BaseView {
    private let containerView = UIView()
    private let titleLabel = UILabel()

    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
    }

    override func styleViews() {
        containerView.backgroundColor = .customYellow
        containerView.layer.cornerRadius = 16

        titleLabel.font = .robotoBold12
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }

    override func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }

        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.centerX.equalToSuperview()
        }
    }

    func configure(with incidents: [Incident], event: EventViewModel) {
        let validIncidents = incidents.filter {
            guard let desc = $0.description, !desc.isEmpty, desc.lowercased() != "unknown" else { return false }
            return true
        }

        guard let firstIncident = validIncidents.first else {
            titleLabel.text = ""
            return
        }

        let desc = firstIncident.description ?? ""
        let scoreText = firstIncident.score.map { " (\($0))" } ?? ""

        if event.matchStatus != .inProgress {
            let displayText = desc + scoreText
            titleLabel.text = displayText
            titleLabel.textColor = .customBlack
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
        titleLabel.textColor = .customRed
    }
}
