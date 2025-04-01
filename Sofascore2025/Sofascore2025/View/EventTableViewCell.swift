//
//  EventTableViewCell.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 25.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class EventTableViewCell: UITableViewCell, BaseViewProtocol {
    private let eventView = EventView()
    static let reuseIdentifier = "EventCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        styleViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        contentView.addSubview(eventView)
    }
    
    func styleViews() {
        eventView.backgroundColor = .white
    }
    
    func setupConstraints() {
        eventView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func configure(with viewModel: EventViewModel) {
        eventView.configure(with: viewModel)
    }
}
