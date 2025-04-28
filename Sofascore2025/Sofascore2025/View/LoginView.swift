import SnapKit
import UIKit
import SofaAcademic

final class LoginView: BaseView {
    private let logoImageView = UIImageView()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let notLoggedLabel = UILabel()
    private let loader = UIActivityIndicatorView(style: .medium)
    
    var onLoginTap: (() -> Void)?
    
    var username: String {
        usernameTextField.text ?? ""
    }
        
    var password: String {
        passwordTextField.text ?? ""
    }
    
    override func addViews() {
        addSubview(logoImageView)
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(loader)
        addSubview(notLoggedLabel)
    }
    
    override func styleViews() {
        logoImageView.image = UIImage(named: "sofascore_lockup")
        logoImageView.tintColor = .customBlue
        
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        usernameTextField.placeholder = "Username"
        usernameTextField.autocapitalizationType = .none
        usernameTextField.font = .robotoRegular14
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor.customBlue.cgColor
        usernameTextField.layer.cornerRadius = 2
        usernameTextField.borderStyle = .none
        usernameTextField.contentVerticalAlignment = .center
        usernameTextField.textColor = .customBlack
        
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.font = .robotoRegular14
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.customBlue.cgColor
        passwordTextField.layer.cornerRadius = 2
        passwordTextField.borderStyle = .none
        passwordTextField.contentVerticalAlignment = .center
        passwordTextField.textColor = .customBlack
    
        [usernameTextField, passwordTextField].forEach { textField in
            textField.borderStyle = .roundedRect
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 0))
            textField.leftView = paddingView
            textField.leftViewMode = .always
        }
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .customBlue
        loginButton.titleLabel!.textAlignment = .center
        loginButton.titleLabel!.font = .robotoRegular14
        
        loader.color = .customBlue
        
        notLoggedLabel.font = .robotoRegular12
        notLoggedLabel.textColor = .customBlack
        notLoggedLabel.text = "Wrong username or password. Try again."
        notLoggedLabel.isHidden = true
        notLoggedLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
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
        
        notLoggedLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.equalTo(passwordTextField)
        }
        
        loader.snp.makeConstraints {
            $0.top.equalTo(notLoggedLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.equalTo(notLoggedLabel)
        }
    }
    
    func showLoader() {
        loader.startAnimating()
    }
        
    func hideLoader() {
        loader.stopAnimating()
    }
    
    func showLabel() {
        notLoggedLabel.isHidden = false
    }
    
    @objc private func loginTapped() {
        onLoginTap?()
    }
}
