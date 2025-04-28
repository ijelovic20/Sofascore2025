import UIKit
import SnapKit
import SofaAcademic

final class SettingsView: BaseView {
    private let titleLabel = UILabel()
    private let dismissButton = UIButton()
    private let nameLabel = UILabel()
    private let leagueLabel = UILabel()
    private let eventsLabel = UILabel()
    
    var onDismissTap: (() -> Void)?

    override func addViews() {
        addSubview(titleLabel)
        addSubview(dismissButton)
        addSubview(nameLabel)
        addSubview(leagueLabel)
        addSubview(eventsLabel)
    }

    override func styleViews() {
        backgroundColor = .white

        titleLabel.text = "Settings"
        titleLabel.font = .robotoBold14
        titleLabel.textAlignment = .center
        
        nameLabel.font = .robotoRegular14

        dismissButton.setTitle("Logout", for: .normal)
        dismissButton.backgroundColor = .customBlue
        dismissButton.titleLabel?.font = .robotoRegular14
        
        leagueLabel.font = .robotoRegular14
        leagueLabel.textAlignment = .center
        leagueLabel.textColor = .customBlack
        
        eventsLabel.font = .robotoRegular14
        eventsLabel.textAlignment = .center
        eventsLabel.textColor = .customBlack
        
        dismissButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.equalTo(titleLabel)
            $0.centerY.equalToSuperview()
        }
        
        leagueLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(nameLabel)
        }
        
        eventsLabel.snp.makeConstraints {
            $0.top.equalTo(leagueLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(leagueLabel)
        }

        dismissButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(32)
            $0.centerX.equalTo(nameLabel)
            $0.width.equalTo(120)
            $0.height.equalTo(32)
        }
    }
    
    func configure() {
        nameLabel.text = LoginPersistenceManager.getData().name
        
        leagueLabel.text = "League count: \(DatabaseManager.shared.leagueCount())"
        eventsLabel.text = "Events count: \(DatabaseManager.shared.eventCount())"
    }
    
    @objc private func dismissTapped() {
        onDismissTap?()
    }
}
