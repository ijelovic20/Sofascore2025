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
        let leagueViewModel = LeagueViewModel(league: league)
        leagueView.configure(with: leagueViewModel)

        let events = dataSource.laLigaEvents()
        self.setEvents(events)
    }

    private func setEvents(_ events: [Event]) {
        var previousView: UIView = leagueView

        for event in events {
            let eventView = EventView()
            eventView.configure(with: EventViewModel(event: event))
            
            view.addSubview(eventView)
            eventView.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(previousView.snp.bottom)
            }
            previousView = eventView
        }
    }
}
