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

    private let containerView = UIView()
    private let logoImageView = UIImageView()
    private let countryLabel = UILabel()
    private let leagueLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    func configure(with viewModel: LeagueViewModel) {
        countryLabel.text = viewModel.countryName
        leagueLabel.text = viewModel.leagueName
        
        if let logoUrlString = viewModel.logoUrl, let url = URL(string: logoUrlString) {
            logoImageView.setImageURL(url)
        }
    }
    
    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(countryLabel)
        containerView.addSubview(leagueLabel)
        containerView.addSubview(arrowImageView)
    }
    
    override func styleViews() {
        countryLabel.font = .robotoBold14
        leagueLabel.font = .robotoRegular14

        countryLabel.textColor = .customBlack
        leagueLabel.textColor = .customBlack

        arrowImageView.image = UIImage(named: "ic_pointer_right")
        arrowImageView.contentMode = .scaleAspectFit
    }
    
    override func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        logoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().inset(12)
            make.size.equalTo(32)
        }

        countryLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoImageView.snp.trailing).offset(32)
            make.centerY.equalTo(logoImageView)
        }

        arrowImageView.snp.makeConstraints { make in
            make.leading.equalTo(countryLabel.snp.trailing)
            make.centerY.equalTo(logoImageView)
            make.size.equalTo(24)
        }

        leagueLabel.snp.makeConstraints { make in
            make.leading.equalTo(arrowImageView.snp.trailing)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview().inset(16)
        }
    }

    override func setupGestureRecognizers() {
    }

    override func setupBinding() {
    }

    var countryName: String? {
        didSet {
            countryLabel.text = countryName
        }
    }

    var leagueName: String? {
        didSet {
            leagueLabel.text = leagueName
        }
    }

    var logoImage: UIImage? {
        didSet {
            logoImageView.image = logoImage
        }
    }
}
