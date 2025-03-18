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
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func fetchData() {
        let league = dataSource.laLigaLeague()
        let events = dataSource.laLigaEvents()
        var eventViewModels: [EventViewModel] = []

        let viewModel = LeagueViewModel(
            leagueName: league.name,
            countryName: league.country?.name ?? "Nepoznato",
            logoURL: URL(string: league.logoUrl ?? "")
        )

        leagueView.configure(with: viewModel)

        eventViewModels = events
            .map { EventViewModel(event: $0) }

        self.setEvents(eventViewModels)
    }

    private func setEvents(_ viewModels: [EventViewModel]) {
        var previousView: UIView = leagueView

        for viewModel in viewModels {
            let eventView = EventView()
            
            eventView.configure(with: viewModel)

            view.addSubview(eventView)
            eventView.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(previousView.snp.bottom)
            }
            previousView = eventView
        }
    }
}
