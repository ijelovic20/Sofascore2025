//
//  ViewController.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 05.03.2025..
//

import UIKit
//import SofaAcademic
import SofaAcademic2

class ViewController: UIViewController {
    private let dataSource = Homework3DataSource()
    private let menu = Menu()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    var groupedEvents: [(league: League?, events: [Event])] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchData()
        
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
    }

    private func setupUI() {
        view.addSubview(menu)
        view.addSubview(tableView)

        menu.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(menu.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "EventCell")
    }

    private func fetchData() {
        let allEvents = dataSource.events()
        
        let grouped = Dictionary(grouping: allEvents, by: { $0.league?.id ?? -1 })
        
        groupedEvents = grouped.compactMap { (id, events) in
            guard let league = events.first?.league else { return nil }
            return (league, events)
        }
        tableView.reloadData()
    }
}
