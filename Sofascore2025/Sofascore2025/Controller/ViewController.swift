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
        let league = dataSource.laLigaLeague()
        let events = dataSource.laLigaEvents()

        // Postavljamo podatke za ligu
        leagueView.countryName = league.country?.name ?? "Nepoznato"
        leagueView.leagueName = league.name

        if let logoUrl = league.logoUrl {
            fetchImage(from: logoUrl) { image in
                self.leagueView.logoImage = image
            }
        }

        // Dodajemo utakmice
        var previousView: UIView = leagueView

        for event in events {
            let matchView = MatchView()
            matchView.homeTeamName = event.homeTeam.name
            matchView.awayTeamName = event.awayTeam.name

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

