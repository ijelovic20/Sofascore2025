//
//  EventTableViewCell.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 25.03.2025..
//

import UIKit
import SnapKit

class EventTableViewCell: UITableViewCell {
    private let eventView = EventView()
    private let homescoreLabel = UILabel()
    private let awayscoreLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(eventView)
        eventView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: EventViewModel) {
        eventView.configure(with: viewModel)
    }
}
