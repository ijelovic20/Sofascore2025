import UIKit
import SofaAcademic

class EventDetailsViewController: UIViewController, BaseViewProtocol {
    private let event: Event

    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Dodaj potrebne podviewove, npr: EventDetailView

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()
        setupBinding()
    }

    func addViews() {
        // Dodaj podviewove (npr. EventDetailView)
    }

    func styleViews() {
        view.backgroundColor = .white
    }

    func setupConstraints() {
        // SnapKit constraints
    }

    func setupBinding() {
        // Ako koristiš view model ili nešto slično
    }
}
