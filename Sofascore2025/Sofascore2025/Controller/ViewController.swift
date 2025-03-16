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
        
        leagueView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

    private func fetchData() {
        let leagueData = dataSource.laLigaLeague()
        let fetchedSofaEvents = dataSource.laLigaEvents()

        let viewModel = LeagueViewModel(
            leagueName: leagueData.name,
            countryName: leagueData.country?.name ?? "Nepoznato",
            logoUrl: leagueData.logoUrl
        )

        leagueView.configure(with: viewModel)

        self.eventViewModels = fetchedSofaEvents
            .map { EventViewModel(event: $0) }

        self.setEvents(self.eventViewModels)
    }


    private func setEvents(_ viewModels: [EventViewModel]) {
        var previousView: UIView = leagueView

        for viewModel in eventViewModels {
            let eventView = EventView()
            
            eventView.configure(with: viewModel)
            
            view.addSubview(eventView)

            eventView.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
                make.top.equalTo(previousView.snp.bottom).offset(12)
            }

            previousView = eventView
        }
    }
}
