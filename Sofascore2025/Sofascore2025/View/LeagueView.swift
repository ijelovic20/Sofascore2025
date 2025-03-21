//
//  LeagueView.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 12.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class LeagueView: BaseView {
    private let logoImageView = UIImageView()
    private let countryLabel = UILabel()
    private let leagueLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    func configure(with viewModel: LeagueViewModel) {
        countryLabel.text = viewModel.countryName
        leagueLabel.text = viewModel.leagueName
        
        if let logoUrl = viewModel.logoURL {
            logoImageView.setImageURL(logoUrl)
        }
    }
    
    override func addViews() {
        self.addSubview(logoImageView)
        self.addSubview(countryLabel)
        self.addSubview(leagueLabel)
        self.addSubview(arrowImageView)
    }
    
    override func styleViews() {
        countryLabel.font = .robotoBold14
        leagueLabel.font = .robotoRegular14

        countryLabel.textColor = .customBlack
        leagueLabel.textColor = .customBlack
        
        leagueLabel.alpha = 0.4

        arrowImageView.image = UIImage(named: "ic_pointer_right")
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.tintColor = .customBlack
        arrowImageView.alpha = 0.4
    }
    
    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().inset(12)
            $0.size.equalTo(32)
        }

        countryLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(32)
            $0.centerY.equalTo(logoImageView)
        }

        arrowImageView.snp.makeConstraints {
            $0.leading.equalTo(countryLabel.snp.trailing)
            $0.centerY.equalTo(logoImageView)
            $0.size.equalTo(24)
        }

        leagueLabel.snp.makeConstraints {
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.leading.equalTo(arrowImageView.snp.trailing)
            $0.centerY.equalTo(arrowImageView)
        }
    }
}
