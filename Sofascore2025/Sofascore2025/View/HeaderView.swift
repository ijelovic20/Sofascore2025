import UIKit
import SnapKit
import SofaAcademic

protocol HeaderViewDelegate: AnyObject {
    func didTapSettings()
}

class HeaderView: BaseView {
    private let logoImageView = UIImageView()
    private let tropheyImageView = UIImageView()
    private let settingsImageView = UIImageView()
    private let settingsContainerView = UIView()
    private let tropheyContainerView = UIView()
    
    weak var delegate: HeaderViewDelegate?

    override func addViews() {
        addSubview(logoImageView)
        addSubview(tropheyImageView)
        addSubview(settingsContainerView)
        addSubview(tropheyContainerView)
        
        settingsContainerView.addSubview(settingsImageView)
        tropheyContainerView.addSubview(tropheyImageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSettingsIcon))
        settingsImageView.isUserInteractionEnabled = true
        settingsImageView.addGestureRecognizer(tapGesture)
    }
    
    override func styleViews() {
        backgroundColor = .customBlue
        
        logoImageView.image = UIImage(named: "sofascore_lockup")
        tropheyImageView.image = UIImage(named: "trophy_icon")
        settingsImageView.image = UIImage(named: "setting_icon")
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().inset(14)
            $0.width.equalTo(132)
            $0.height.equalTo(20)
        }

        settingsContainerView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4)
            $0.centerY.equalTo(logoImageView)
            $0.size.equalTo(48)
        }

        settingsImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(24)
        }

        tropheyContainerView.snp.makeConstraints {
            $0.trailing.equalTo(settingsContainerView.snp.leading)
            $0.size.equalTo(48)
        }

        tropheyImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
    
    @objc private func didTapSettingsIcon() {
        delegate?.didTapSettings()
    }
}
