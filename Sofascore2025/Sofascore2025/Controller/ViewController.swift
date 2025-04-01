//
//  ViewController.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 05.03.2025..
//

import UIKit
import SofaAcademic

class ViewController: UIViewController, BaseViewProtocol {
    private let dataSource = Homework3DataSource()
    private let menu = MenuView()
    private let tableView = UITableView(frame: .zero, style: .plain)

    var groupedEvents: [(league: League?, events: [Event])] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        setupBinding()
    }

    func addViews() {
        view.addSubview(menu)
        view.addSubview(tableView)
    }

    func styleViews() {
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = UITableView.automaticDimension
    }

    func setupConstraints() {
        menu.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(menu.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setupBinding() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.reuseIdentifier)
        fetchData()
    }

    private func fetchData() {
        let allEvents = dataSource.events()
        groupedEvents = Dictionary(grouping: allEvents, by: { $0.league?.id ?? -1 })
            .compactMap { (_, events) in
                guard let league = events.first?.league else { return nil }
                return (league, events)
            }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedEvents.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedEvents[section].events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }
        
        let event = groupedEvents[indexPath.section].events[indexPath.row]
        cell.configure(with: EventViewModel(event: event))
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let league = groupedEvents[section].league else { return nil }
        let header = LeagueView()
        header.configure(with: LeagueViewModel(league: league))
        return header
    }
}
