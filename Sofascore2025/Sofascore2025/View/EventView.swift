//
//  EventView.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 13.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class EventView: BaseView {

    private let matchTimeLabel = UILabel()
    private let homeTeamLabel = UILabel()
    private let awayTeamLabel = UILabel()
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    private let divider = UIView()
    private let homeTeamImageView = UIImageView()
    private let awayTeamImageView = UIImageView()
    private let matchStatusLabel = UILabel()

    override func addViews() {
        addSubview(matchTimeLabel)
        addSubview(homeTeamLabel)
        addSubview(awayTeamLabel)
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
        addSubview(divider)
        addSubview(homeTeamImageView)
        addSubview(awayTeamImageView)
        addSubview(matchStatusLabel)
    }

    override func styleViews() {
        [matchTimeLabel, homeTeamLabel, awayTeamLabel, homeScoreLabel, awayScoreLabel, matchStatusLabel].forEach {
            $0.font = .robotoRegular14
            $0.textColor = .customBlack
        }
        homeScoreLabel.textAlignment = .right
        awayScoreLabel.textAlignment = .right
        
        matchTimeLabel.alpha = 0.4
        divider.backgroundColor = .lightGray

        [homeTeamImageView, awayTeamImageView].forEach {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
    }

    override func setupConstraints() {
        matchTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalTo(divider.snp.leading).multipliedBy(0.5)
        }

        matchStatusLabel.snp.makeConstraints {
            $0.top.equalTo(matchTimeLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(matchTimeLabel)
        }

        divider.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(63)
            $0.top.equalToSuperview().offset(8)
            $0.width.equalTo(1)
            $0.height.equalTo(40)
        }

        homeTeamImageView.snp.remakeConstraints {
            $0.top.equalTo(divider.snp.top)
            $0.leading.equalTo(divider.snp.trailing).offset(16)
            $0.size.equalTo(16)
        }

        awayTeamImageView.snp.remakeConstraints {
            $0.bottom.equalTo(divider.snp.bottom)
            $0.leading.equalTo(divider.snp.trailing).offset(16)
            $0.size.equalTo(16)
        }

        homeTeamLabel.snp.makeConstraints {
            $0.leading.equalTo(homeTeamImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(homeTeamImageView)
            $0.width.equalTo(192)
        }

        awayTeamLabel.snp.makeConstraints {
            $0.leading.equalTo(awayTeamImageView.snp.trailing).offset(8)
            $0.top.equalTo(homeTeamLabel.snp.bottom).offset(8)
            $0.width.equalTo(192)
        }

        homeScoreLabel.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.centerY.equalTo(homeTeamLabel)
            $0.leading.equalTo(homeTeamLabel.snp.trailing).offset(16)
        }

        awayScoreLabel.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.centerY.equalTo(awayTeamLabel)
            $0.leading.equalTo(awayTeamLabel.snp.trailing).offset(16)
        }

        self.snp.makeConstraints {
            $0.bottom.equalTo(awayScoreLabel.snp.bottom).offset(8)
        }
    }

    func configure(with viewModel: EventViewModel,
                   statusText: String,
                   statusColor: UIColor,
                   homeAlpha: CGFloat,
                   awayAlpha: CGFloat) {

        homeTeamLabel.text = viewModel.homeTeamName
        awayTeamLabel.text = viewModel.awayTeamName
        homeScoreLabel.text = "\(viewModel.homeScoreText)"
        awayScoreLabel.text = "\(viewModel.awayScoreText)"
        matchTimeLabel.text = viewModel.formattedTime
        matchStatusLabel.text = statusText
        
        if(statusText != "-" && statusText != "FT"){
            matchStatusLabel.alpha = 1
        } else {
            matchStatusLabel.alpha = 0.4
        }

        matchStatusLabel.textColor = statusColor
        homeScoreLabel.textColor = statusColor
        awayScoreLabel.textColor = statusColor
        homeTeamLabel.alpha = homeAlpha
        homeScoreLabel.alpha = homeAlpha
        awayTeamLabel.alpha = awayAlpha
        awayScoreLabel.alpha = awayAlpha
        
        if let homeURL = viewModel.homeTeamLogoURL {
            homeTeamImageView.setImageURL(homeURL)
        }

        if let awayURL = viewModel.awayTeamLogoURL {
            awayTeamImageView.setImageURL(awayURL)
        }
    }
}
