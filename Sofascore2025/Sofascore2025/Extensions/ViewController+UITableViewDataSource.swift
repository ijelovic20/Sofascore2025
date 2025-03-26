//
//  ViewController+UITableViewDataSource.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 26.03.2025..
//

import UIKit

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedEvents.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedEvents[section].events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        let event = groupedEvents[indexPath.section].events[indexPath.row]
        cell.configure(with: EventViewModel(event: event))
        return cell
    }
}
