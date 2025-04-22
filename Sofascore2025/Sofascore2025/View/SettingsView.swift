import UIKit
import SnapKit
import SofaAcademic

class SettingsView: BaseView {
    let titleLabel = UILabel()
    let dismissButton = UIButton()
    private let nameLabel = UILabel()
    private let leagueLabel = UILabel()
    private let eventsLabel = UILabel()

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

        dismissButton.setTitle("Logout", for: .normal)
        dismissButton.backgroundColor = .customBlue
        dismissButton.titleLabel?.font = .robotoRegular14
        
        leagueLabel.font = .robotoRegular14
        leagueLabel.textAlignment = .center
        leagueLabel.textColor = .customBlack
        
        eventsLabel.font = .robotoRegular14
        eventsLabel.textAlignment = .center
        eventsLabel.textColor = .customBlack
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
            $0.bottom.equalToSuperview().offset(-32)
            $0.centerX.equalTo(nameLabel)
            $0.width.equalTo(120)
            $0.height.equalTo(32)
        }
    }
    
    func configure (with name: String) {
        nameLabel.text = name
        nameLabel.font = .robotoRegular14
        
        leagueLabel.text = "League count: \(DBManager.shared.leagueCount())"
        
        eventsLabel.text = "Events count: \(DBManager.shared.eventCount())"
    }
}
