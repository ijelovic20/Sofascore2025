import UIKit
import SofaAcademic
import Combine
import SnapKit

class EventDetailsViewController: UIViewController, BaseViewProtocol {
    private let event: EventViewModel
    private let league: LeagueViewModel
    var sportName: Sport
    
    private let scrollView = UIScrollView()
    private let eventDetailView: EventDetailView = .init()
    private let upcomingEventView: UpcomingEventView = .init()
    private let incidentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    private var activeDetailSubview: UIView!
    private var cancellables = Set<AnyCancellable>()

    init(event: EventViewModel, league: LeagueViewModel, sportName: Sport) {
        self.event = event
        self.league = league
        self.sportName = sportName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        eventDetailView.configure(with: event, league: league, sportName: sportName.rawValue)

        eventDetailView.backButtonTappedPublisher
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)

        if event.matchStatus == .notStarted {
            activeDetailSubview = upcomingEventView
        } else {
            scrollView.addSubview(incidentStackView)
            activeDetailSubview = scrollView
        }

        addViews()
        styleViews()
        setupConstraints()
        setupGestureRecognizers()

        if event.matchStatus != .notStarted {
            fetchAndDisplayIncidents()
        }
    }

    func addViews() {
        view.addSubview(eventDetailView)
        view.addSubview(activeDetailSubview)
    }

    func styleViews() {
        eventDetailView.backgroundColor = .white
        view.backgroundColor = .white
    }

    func setupConstraints() {
        eventDetailView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        activeDetailSubview.snp.makeConstraints {
            $0.top.equalTo(eventDetailView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }

        if event.matchStatus != .notStarted {
            incidentStackView.snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.width.equalToSuperview()
            }
        }
    }

    func setupGestureRecognizers() {
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        eventDetailView.addGestureRecognizer(backGesture)
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func fetchAndDisplayIncidents() {
        Task {
            do {
                let incidents = try await APIClient.fetchIncidents(forEventId: event.eventId)

                let sortedIncidents = incidents.sorted {
                    ($0.minute ?? 0) > ($1.minute ?? 0)
                }

                DispatchQueue.main.async {
                    self.incidentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

                    if self.event.matchStatus == .inProgress {
                        let firstHalfHeader = HeaderIncidentView()
                        let resultText = "First Half (\(self.event.homeScoreText)-\(self.event.awayScoreText))"
                        firstHalfHeader.configure(title: resultText)
                        self.incidentStackView.addArrangedSubview(firstHalfHeader)
                    }

                    for incident in sortedIncidents {
                        if incident.type == .periodEnd {
                            let header = HeaderIncidentView()
                            header.configure(with: [incident], event: self.event)
                            self.incidentStackView.addArrangedSubview(header)
                        } else {
                            let detail = IncidentDetailView()
                            detail.configure(with: incident)
                            self.incidentStackView.addArrangedSubview(detail)
                        }
                    }
                }
            } catch {
                print("error ", error)
            }
        }
    }
}
