//
//  ViewController.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 05.03.2025..
//

import UIKit
import SofaAcademic

class ViewController: UIViewController {

    private let leagueView = LeagueView()
    private let dataSource = Homework2DataSource()
    private var eventViewModels: [EventViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchData()
    }

    private func setupUI() {
        view.addSubview(leagueView)
        
        leagueView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }

    private func fetchData() {
        let leagueData = dataSource.laLigaLeague()
        let events = dataSource.laLigaEvents()

        let viewModel = LeagueViewModel(
            leagueName: leagueData.name,
            countryName: leagueData.country?.name ?? "Nepoznato",
            logoURL: URL(string: leagueData.logoUrl ?? "")
        )

        leagueView.configure(with: viewModel)

        self.eventViewModels = events
            .map { EventViewModel(event: $0) }

        self.setEvents(self.eventViewModels)
    }

    private func setEvents(_ viewModels: [EventViewModel]) {
        var previousView: UIView = leagueView

        for viewModel in viewModels {
            let eventView = EventView()
            let matchStatus = viewModel.matchStatus

            var statusText = "-"
            var statusColor: UIColor = .customBlack
            var homeAlpha: CGFloat = 1
            var awayAlpha: CGFloat = 1

            switch matchStatus {
            case .notStarted:
                statusText = "-"
            case .finished:
                statusText = "FT"
                if let home = Int(viewModel.homeScoreText),
                    let away = Int(viewModel.awayScoreText) {
                        if home > away {
                            awayAlpha = 0.4
                        } else if away > home {
                            homeAlpha = 0.4
                        }
                    }
            case .inProgress:
                statusText = "\(viewModel.matchMinute ?? 0)'"
                statusColor = .customRed
            default:
                statusText = "-"
            }

            eventView.configure(
                with: viewModel,
                statusText: statusText,
                statusColor: statusColor,
                homeAlpha: homeAlpha,
                awayAlpha: awayAlpha
            )

            view.addSubview(eventView)
            eventView.snp.makeConstraints {
                $0.left.right.equalToSuperview().inset(4)
                $0.top.equalTo(previousView.snp.bottom).offset(12)
            }
            previousView = eventView
        }
    }
}
