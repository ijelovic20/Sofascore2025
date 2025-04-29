import UIKit
import SofaAcademic

class LoginViewController: UIViewController, BaseViewProtocol {
    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        loginView.onLoginTap = { [weak self] in
            self?.handleLogin()
        }
            
        styleViews()
        addViews()
        setupConstraints()
    }
        
    func addViews() {
        view.addSubview(loginView)
    }
        
    func styleViews() {
        loginView.backgroundColor = .white
    }
        
    func setupConstraints() {
        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc private func handleLogin() {
        loginView.showLoader()

        Task {
            do {
                let response = try await APIClient.login(username: loginView.username, password: loginView.password)
                                
                LoginPersistenceManager.saveData(token: response.token, name: response.name)
                                
                self.dismiss(animated: true, completion: {
                    let mainVC = ViewController()
                    self.navigationController?.pushViewController(mainVC, animated: true)
                })
            } catch {
                loginView.showLabel()
                print("Login failed: \(error.localizedDescription)")
                
                self.loginView.hideLoader()
            }
        }
    }
}
