import SnapKit
import UIKit
import SofaAcademic

class LoginView: BaseView {
    private let logoImageView = UIImageView()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    override func addViews() {
        addSubview(logoImageView)
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
    }
    
    override func styleViews() {
        logoImageView.image = UIImage(named: "sofascore_lockup")
        logoImageView.tintColor = .customBlue
        
        usernameTextField.placeholder = "Username"
        usernameTextField.autocapitalizationType = .none
        usernameTextField.font = .robotoRegular14
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor.customBlue.cgColor
        usernameTextField.layer.cornerRadius = 2
        usernameTextField.borderStyle = .none
        usernameTextField.contentVerticalAlignment = .center
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        usernameTextField.leftView = paddingView
        usernameTextField.leftViewMode = .always
        
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.font = .robotoRegular14
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.customBlue.cgColor
        passwordTextField.layer.cornerRadius = 2
        passwordTextField.borderStyle = .none
        passwordTextField.contentVerticalAlignment = .center
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .customBlue
        loginButton.titleLabel!.textAlignment = .center
        loginButton.titleLabel!.font = .robotoRegular14
    }
    
    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
            $0.width.equalTo(132)
            $0.height.equalTo(20)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview().inset(20)
            $0.height.equalTo(32)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.equalTo(usernameTextField)
            $0.height.equalTo(32)
        }
        
        loginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-32)
            $0.centerX.equalTo(passwordTextField)
            $0.width.equalTo(120)
            $0.height.equalTo(32)
        }
    }
}
