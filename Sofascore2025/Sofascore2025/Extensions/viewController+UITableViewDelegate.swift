//
//  viewController+UITableViewDelegate.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 26.03.2025..
//

import UIKit

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let league = groupedEvents[section].league else { return nil }
        let header = LeagueHeaderView()
        header.configure(with: LeagueViewModel(league: league))
        return header
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == groupedEvents.count - 1 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let dividerView = UIView()
        dividerView.backgroundColor = .customGray
        return dividerView
    }
}
