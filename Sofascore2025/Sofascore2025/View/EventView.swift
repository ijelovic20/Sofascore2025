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

        matchTimeLabel.alpha = 0.4
        matchStatusLabel.alpha = 0.6
        divider.backgroundColor = .lightGray

        [homeTeamImageView, awayTeamImageView].forEach {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
    }

    override func setupConstraints() {
        matchTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalTo(divider.snp.leading).multipliedBy(0.5)
        }

        matchStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(matchTimeLabel.snp.bottom).offset(4)
            make.centerX.equalTo(matchTimeLabel)
        }

        divider.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(63)
            make.top.equalToSuperview().offset(8)
            make.width.equalTo(1)
            make.height.equalTo(40)
        }

        homeTeamImageView.snp.makeConstraints { make in
            make.centerY.equalTo(homeTeamLabel)
            make.trailing.equalTo(homeTeamLabel.snp.leading).offset(-8)
            make.size.equalTo(16)
        }

        awayTeamImageView.snp.makeConstraints { make in
            make.centerY.equalTo(awayTeamLabel)
            make.trailing.equalTo(awayTeamLabel.snp.leading).offset(-8)
            make.size.equalTo(16)
        }

        homeTeamLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(104)
            make.top.equalToSuperview().offset(8)
        }

        awayTeamLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(104)
            make.top.equalTo(homeTeamLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }

        homeScoreLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
        }

        awayScoreLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(homeScoreLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

    override func setupGestureRecognizers() {}

    override func setupBinding() {}

    func configure(with viewModel: EventViewModel) {
        homeTeamLabel.text = viewModel.homeTeamName
        awayTeamLabel.text = viewModel.awayTeamName
        homeScoreLabel.text = "\(viewModel.homeScoreText)"
        awayScoreLabel.text = "\(viewModel.awayScoreText)"
        matchTimeLabel.text = viewModel.formattedTime

        resetAlpha()
        matchStatusLabel.textColor = .customBlack
        homeScoreLabel.textColor = .customBlack
        awayScoreLabel.textColor = .customBlack

        switch viewModel.matchStatus {
        case .notStarted:
            matchStatusLabel.text = "-"
            homeScoreLabel.text = ""
            awayScoreLabel.text = ""

        case .finished:
            matchStatusLabel.text = "FT"
            if let homeScore = Int(viewModel.homeScoreText),
               let awayScore = Int(viewModel.awayScoreText) {
                if homeScore > awayScore {
                    awayTeamLabel.alpha = 0.4
                    awayScoreLabel.alpha = 0.4
                } else if awayScore > homeScore {
                    homeTeamLabel.alpha = 0.4
                    homeScoreLabel.alpha = 0.4
                } else {
                    resetAlpha()
                }
            }

        case .inProgress:
            matchStatusLabel.textColor = .customRed
            homeScoreLabel.textColor = .customRed
            awayScoreLabel.textColor = .customRed
            if let matchMinute = viewModel.matchMinute {
                matchStatusLabel.text = "\(matchMinute)'"
            }

        default:
            matchStatusLabel.text = "-"
        }

        if let homeURL = viewModel.homeTeamLogoURL {
            homeTeamImageView.setImageURL(homeURL)
        }

        if let awayURL = viewModel.awayTeamLogoURL {
            awayTeamImageView.setImageURL(awayURL)
        }
    }

    private func resetAlpha() {
        homeTeamLabel.alpha = 1
        awayTeamLabel.alpha = 1
        homeScoreLabel.alpha = 1
        awayScoreLabel.alpha = 1
    }
}
