import UIKit
import SnapKit

class TeamDetailViewController: UIViewController {
    private let teamName: String
    private let teamDetailView = TeamDetailView()

    init(teamName: String) {
        self.teamName = teamName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(teamDetailView)
        
        teamDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        // Primjer prikaza imena tima
        let label = UILabel()
        label.text = teamName
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        teamDetailView.addSubview(label)

        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
