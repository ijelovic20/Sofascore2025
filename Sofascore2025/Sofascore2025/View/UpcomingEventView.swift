import Foundation
import UIKit
import SnapKit
import SofaAcademic

class UpcomingEventView: BaseView{
    private let containerView = UIView()
    private let incidentLabel = UILabel()
    private let button = UIButton(type: .system)
    
    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(incidentLabel)
        
        addSubview(button)
    }
    
    override func styleViews() {
        containerView.backgroundColor = .customBlueGray
        containerView.layer.cornerRadius = 8
        
        incidentLabel.font = .robotoRegular14
        incidentLabel.textColor = .customGray
        incidentLabel.text = "No results yet."
        
        button.titleLabel?.font = .robotoBold16
        button.setTitle("View Tournament Details", for: .normal)
        button.setTitleColor(.customBlue, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.customBlue.cgColor
    }
    
    override func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
        }
        
        incidentLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(16)
            $0.centerX.equalTo(containerView)
            $0.width.equalTo(212)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
