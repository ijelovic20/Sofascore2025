//
//  LeagueHeaderView.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 25.03.2025..
//

import UIKit
import SnapKit

class LeagueHeaderView: UIView {
    private let leagueView = LeagueView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(leagueView)
        leagueView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: LeagueViewModel) {
        leagueView.configure(with: viewModel)
    }
}
