import UIKit
import SofaAcademic

class SettingsViewController: UIViewController, BaseViewProtocol {
    private let name: String
    private let settingsView = SettingsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        styleViews()
        addViews()
        setupConstraints()

        settingsView.configure(with: name)
        settingsView.dismissButton.addTarget(self, action: #selector(dismissSettings), for: .touchUpInside)
    }
    
    init(name: String){
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        view.addSubview(settingsView)
    }

    func setupConstraints() {
        settingsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    @objc func dismissSettings() {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "name")

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            
            let loginVC = LoginViewController()
            let navController = UINavigationController(rootViewController: loginVC)
            
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
    }
}
