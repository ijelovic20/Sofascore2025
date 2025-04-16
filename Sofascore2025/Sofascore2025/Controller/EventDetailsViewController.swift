import UIKit
import SofaAcademic
import Combine

class EventDetailsViewController: UIViewController, BaseViewProtocol {
    private let event: EventViewModel
    private let league: LeagueViewModel
    var sportName: Sport
    
    private let eventDetailView: EventDetailView  = .init()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventDetailView.configure(with: event, league: league, sportName: sportName.rawValue)
        
        eventDetailView.backButtonTappedPublisher.sink { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }.store(in: &cancellables)
        
        addViews()
        styleViews()
        setupConstraints()
    }
    
    init(event: EventViewModel, league: LeagueViewModel, sportName: Sport) {
        self.event = event
        self.league = league
        self.sportName = sportName
        super.init(nibName: nil, bundle: nil)
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
        navigationController?.popViewController(animated: true)
    }
}
