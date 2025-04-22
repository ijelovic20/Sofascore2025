import UIKit
import SnapKit
import SofaAcademic

class SettingsView: BaseView {
    let titleLabel = UILabel()
    let dismissButton = UIButton()
    private let nameLabel = UILabel()

    override func addViews() {
        addSubview(titleLabel)
        addSubview(dismissButton)
        addSubview(nameLabel)
    }

    override func styleViews() {
        backgroundColor = .white

        titleLabel.text = "Settings"
        titleLabel.font = .robotoBold14
        titleLabel.textAlignment = .center

        dismissButton.setTitle("Logout", for: .normal)
        dismissButton.backgroundColor = .customBlue
        dismissButton.titleLabel?.font = .robotoRegular14
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
    }
}
