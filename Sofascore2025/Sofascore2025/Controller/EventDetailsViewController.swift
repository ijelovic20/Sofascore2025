import UIKit
import SofaAcademic

class EventDetailsViewController: UIViewController, BaseViewProtocol {
    private let event: EventViewModel
    private let league: LeagueViewModel
    var sportName: String
    
    private lazy var eventDetailView: EventDetailView = {
        let view = EventDetailView(event: event, league: league, sportName: sportName)
        return view
    }()
    
    init(event: EventViewModel, league: LeagueViewModel, sportName: String) {
        self.event = event
        self.league = league
        self.sportName = sportName
        super.init(nibName: nil, bundle: nil)
        
        eventDetailView = EventDetailView(event: event, league: league, sportName: sportName)
        
        eventDetailView.configure(with: event, league: league)
        
        addViews()
        styleViews()
        setupConstraints()
        setupGestureRecognizers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        view.addSubview(eventDetailView)
    }

    func styleViews() {
        eventDetailView.backgroundColor = .white
    }

    func setupConstraints() {
        eventDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupGestureRecognizers() {
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        eventDetailView.addGestureRecognizer(backGesture)
    }

    @objc func backButtonTapped() {
        if let navigationController = self.findNavigationController() {
            navigationController.popViewController(animated: true)
        }
    }

    private func findNavigationController() -> UINavigationController? {
        var responder = self.next
        while let nextResponder = responder {
            if let navigationController = nextResponder as? UINavigationController {
                return navigationController
            }
            responder = nextResponder.next
        }
        return nil
    }
}
