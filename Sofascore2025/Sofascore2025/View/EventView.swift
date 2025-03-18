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
        matchTimeLabel.textAlignment = .center
        
        matchTimeLabel.alpha = 0.4
        
        divider.backgroundColor = .lightGray

        [homeTeamImageView, awayTeamImageView].forEach {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
    }

    override func setupConstraints() {
        
        matchTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(4)
            $0.width.equalTo(56)
        }

        matchStatusLabel.snp.makeConstraints {
            $0.top.equalTo(matchTimeLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(matchTimeLabel)
        }

        divider.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(63)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(1)
        }

        homeTeamImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(divider.snp.trailing).offset(16)
            $0.size.equalTo(16)
        }

        awayTeamImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.top.equalTo(homeTeamImageView.snp.bottom).offset(4)
            $0.leading.equalTo(divider.snp.trailing).offset(16)
            $0.size.equalTo(16)
        }

        homeTeamLabel.snp.makeConstraints {
            $0.leading.equalTo(homeTeamImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(homeTeamImageView)
            $0.trailing.equalTo(homeScoreLabel.snp.leading).offset(16)
        }

        awayTeamLabel.snp.makeConstraints {
            $0.leading.equalTo(awayTeamImageView.snp.trailing).offset(8)
            $0.top.equalTo(homeTeamLabel.snp.bottom).offset(8)
            $0.trailing.equalTo(awayScoreLabel.snp.leading).offset(16)
        }

        homeScoreLabel.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.centerY.equalTo(homeTeamLabel)
            $0.trailing.equalToSuperview().offset(-16)
        }

        awayScoreLabel.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.centerY.equalTo(awayTeamLabel)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }

    func configure(with viewModel: EventViewModel) {
        homeTeamLabel.text = viewModel.homeTeamName
        awayTeamLabel.text = viewModel.awayTeamName
        homeScoreLabel.text = viewModel.homeScoreText
        awayScoreLabel.text = viewModel.awayScoreText
        matchTimeLabel.text = viewModel.formattedTime
        matchStatusLabel.text = viewModel.statusString

        homeTeamLabel.alpha = viewModel.homeAlpha
        awayTeamLabel.alpha = viewModel.awayAlpha
        homeScoreLabel.alpha = viewModel.homeAlpha
        awayScoreLabel.alpha = viewModel.awayAlpha
        matchStatusLabel.alpha = viewModel.statusAlpha

        matchStatusLabel.textColor = viewModel.statusColor
        homeScoreLabel.textColor = viewModel.statusColor
        awayScoreLabel.textColor = viewModel.statusColor

        if let homeURL = viewModel.homeTeamLogoURL {
            homeTeamImageView.setImageURL(homeURL)
        }
        if let awayURL = viewModel.awayTeamLogoURL {
            awayTeamImageView.setImageURL(awayURL)
        }
    }

}
