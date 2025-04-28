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
        let username = loginView.username
        let password = loginView.password
        
        loginView.showLoader()

        Task {
            do {
                let response = try await APIClient.login(username: username, password: password)
                
                LoginPersistenceManager.saveData(token: response.token, name: response.name)

                let mainVC = ViewController()
                let navController = UINavigationController(rootViewController: mainVC)
                navController.setNavigationBarHidden(true, animated: false)
                
                loginView.hideLoader()

                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = scene.windows.first,
                   let rootVC = window.rootViewController as? RootViewController {
                        rootVC.showMainApp()
                }
            } catch {
                loginView.showLabel()
                print("Login failed: \(error.localizedDescription)")
                
                self.loginView.hideLoader()
            }
        }
    }
}
