import UIKit
import SofaAcademic

class LoginViewController: UIViewController, BaseViewProtocol {
    private let loginView = LoginView()
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
            
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
        let username = loginView.usernameTextField.text ?? ""
        let password = loginView.passwordTextField.text ?? ""

        Task {
            do {
                let response = try await APIClient.login(username: username, password: password)

                userDefaults.set(response.token, forKey: "token")
                userDefaults.set(response.name, forKey: "name")

                let mainVC = ViewController()
                mainVC.name = response.name
                let navController = UINavigationController(rootViewController: mainVC)
                navController.setNavigationBarHidden(true, animated: false)

                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = scene.windows.first {
                    window.rootViewController = navController
                    window.makeKeyAndVisible()
                }
            } catch {
                print("Login failed: \(error.localizedDescription)")
            }
        }
    }
}
