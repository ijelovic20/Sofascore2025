import UIKit
import SofaAcademic

class SettingsViewController: UIViewController, BaseViewProtocol {
    private let titleLabel: UILabel = .init()
    private let dismissButton: UIButton = .init()
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        styleViews()
        addViews()
        setupConstraints()
    }
        
    func addViews() {
        view.addSubview(titleLabel)
        view.addSubview(dismissButton)
    }
        
    func styleViews() {
        view.backgroundColor = .white
        titleLabel.text = "Settings"
        titleLabel.font = .robotoBold14
        titleLabel.textAlignment = .center
            
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissSettings), for: .touchUpInside)
        dismissButton.backgroundColor = .customBlue
    }
        
    func setupConstraints() {
        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
            
        dismissButton.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(32)
        }
    }
        
    @objc func dismissSettings() {
        dismiss(animated: true)
    }
}
