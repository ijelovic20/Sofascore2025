import Foundation
import UIKit

final class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showInitialScreen()
    }
    
    func showInitialScreen() {
        if LoginPersistenceManager.getData().token != nil {
            showMainApp()
        } else {
            showLogin()
        }
    }
    
    func showLogin() {
        let loginVC = LoginViewController()
        setRootViewController(loginVC)
    }
    
    func showMainApp() {
        let mainVC = ViewController()
        setRootViewController(mainVC)
    }
    
    private func setRootViewController(_ viewController: UIViewController) {
        children.forEach { childVC in
            childVC.willMove(toParent: nil)
            childVC.view.removeFromSuperview()
            childVC.removeFromParent()
        }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.view.frame = view.bounds
        navigationController.didMove(toParent: self)
    }
}
