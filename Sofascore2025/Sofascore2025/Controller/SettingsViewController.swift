import UIKit
import SofaAcademic

class SettingsViewController: UIViewController, BaseViewProtocol {
    private let settingsView = SettingsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        styleViews()
        addViews()
        setupConstraints()
        
        settingsView.configure()

        settingsView.onDismissTap = { [weak self] in
            self?.logout()
        }
    }
    
    init() {
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

    @objc func logout() {
        LoginPersistenceManager.clearData()
        
        DatabaseManager.shared.deleteAllData()

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            
            let rootVC = RootViewController()
            window.rootViewController = rootVC
            window.makeKeyAndVisible()
        }
    }
}
