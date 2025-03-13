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
    private var events: [Event] = []

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
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }

    private func fetchData() {
        let dataSource = Homework2DataSource()
        let leagueData = dataSource.laLigaLeague()
        let fetchedEvents = dataSource.laLigaEvents()

        let country = Country(
            id: leagueData.country?.id ?? 0,
            name: leagueData.country?.name ?? "Nepoznato"
        )

        let league = League(
            id: leagueData.id,
            name: leagueData.name,
            country: country.name,
            logoUrl: leagueData.logoUrl
        )

        self.events = fetchedEvents.map { event in
            let eventCountry = Country(
                id: event.league?.country?.id ?? country.id,
                name: event.league?.country?.name ?? country.name
            )

            return Event(
                id: event.id,
                homeTeam: event.homeTeam.name,
                awayTeam: event.awayTeam.name,
                league: League(
                    id: event.league?.id ?? league.id,
                    name: event.league?.name ?? league.name,
                    country: eventCountry.name,
                    logoUrl: event.league?.logoUrl ?? league.logoUrl
                ),
                status: String(describing: event.status),
                startTimestamp: event.startTimestamp,
                homeScore: event.homeScore ?? 0,
                awayScore: event.awayScore ?? 0
            )
        }

        leagueView.countryName = league.country
        leagueView.leagueName = league.name

        if let logoUrl = league.logoUrl {
            fetchImage(from: logoUrl) { image in
                self.leagueView.logoImage = image
            }
        }

        updateUI()
    }


    private func updateUI() {
        var previousView: UIView = leagueView

        for event in events {
            let matchView = MatchView()
            matchView.homeTeamName = event.homeTeam
            matchView.awayTeamName = event.awayTeam
            matchView.homeScoreName = String(event.homeScore)
            matchView.awayScoreName = String(event.awayScore)
            matchView.matchTimestamp = event.startTimestamp 
            matchView.matchStatus = event.status
            
            view.addSubview(matchView)

            matchView.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
                make.top.equalTo(previousView.snp.bottom).offset(12)
            }

            previousView = matchView
        }
    }


    private func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
