//
//  MatchView.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 13.03.2025..
//

import UIKit
import SnapKit

class MatchView: UIView {

    private let matchTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.alpha = 0.4
        return label
    }()

    private let matchStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.alpha = 0.4
        return label
    }()

    private let homeTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .black
        return label
    }()

    private let awayTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .black
        return label
    }()
    
    private let homeScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .black
        return label
    }()
    
    private let awayScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let homeTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let awayTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()


    private func setupUI() {
        addSubview(matchTimeLabel)
        addSubview(matchStatusLabel)
        addSubview(divider)
        addSubview(homeTeamLabel)
        addSubview(awayTeamLabel)
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
        addSubview(homeTeamImageView)
        addSubview(awayTeamImageView)

        homeTeamImageView.snp.makeConstraints { make in
            make.centerY.equalTo(homeTeamLabel) 
            make.right.equalTo(homeTeamLabel.snp.left).offset(-8)
            make.width.height.equalTo(16)
        }

        awayTeamImageView.snp.makeConstraints { make in
            make.centerY.equalTo(awayTeamLabel)
            make.right.equalTo(awayTeamLabel.snp.left).offset(-8)
            make.width.height.equalTo(16)
        }



        matchTimeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(4)
            make.top.equalToSuperview().offset(8)
        }

        matchStatusLabel.snp.makeConstraints { make in
            make.centerX.equalTo(matchTimeLabel)
            make.top.equalTo(matchTimeLabel.snp.bottom).offset(4)
        }

        divider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(63)
            make.top.equalToSuperview().offset(8)
            make.width.equalTo(1)
            make.height.equalTo(40)
        }

        homeTeamLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(104)
            make.top.equalToSuperview().offset(8)
        }

        awayTeamLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(104)
            make.top.equalTo(homeTeamLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }

        homeScoreLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
        }

        awayScoreLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(homeScoreLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }



    var matchTimestamp: Int? {
        didSet {
            if let timestamp = matchTimestamp {
                matchTimeLabel.text = formatTimestamp(timestamp)
            }
        }
    }

    var matchStatus: String? {
        didSet {
            guard let status = matchStatus else {
                matchStatusLabel.text = "-"
                return
            }

            if status == "notStarted" {
                matchStatusLabel.text = "-"
                homeScoreLabel.text = ""
                awayScoreLabel.text = ""
            } else if status == "finished" {
                matchStatusLabel.text = "FT"
                homeScoreLabel.textColor = .black
                awayScoreLabel.textColor = .black
                
                if let homeScore = Int(homeScoreLabel.text ?? "0"),
                   let awayScore = Int(awayScoreLabel.text ?? "0") {

                    if homeScore > awayScore {
                        awayTeamLabel.alpha = 0.4 
                        awayScoreLabel.alpha = 0.4
                        homeTeamLabel.alpha = 1
                        homeScoreLabel.alpha = 1
                    } else if awayScore > homeScore {
                        homeTeamLabel.alpha = 0.4
                        homeScoreLabel.alpha = 0.4
                        awayTeamLabel.alpha = 1
                        awayScoreLabel.alpha = 1
                    } else {
                        // Ako je neriješeno, sve ostaje normalno
                        homeTeamLabel.alpha = 1
                        homeScoreLabel.alpha = 1
                        awayTeamLabel.alpha = 1
                        awayScoreLabel.alpha = 1
                    }
                }
            }
 else if status == "inProgress" {
                let currentTime = Int(Date().timeIntervalSince1970)
                let elapsedMinutes = (currentTime - (matchTimestamp ?? currentTime)) / 60
                matchStatusLabel.text = "\(elapsedMinutes)'"

                homeScoreLabel.textColor = UIColor(red: 233/255, green: 48/255, blue: 48/255, alpha: 1)
                awayScoreLabel.textColor = UIColor(red: 233/255, green: 48/255, blue: 48/255, alpha: 1)
                matchStatusLabel.textColor = UIColor(red: 233/255, green: 48/255, blue: 48/255, alpha: 1)
                matchStatusLabel.alpha = 1
            } else {
                matchStatusLabel.text = "-"
                homeScoreLabel.textColor = .black
                awayScoreLabel.textColor = .black
            }
        }
    }

    var homeTeamName: String? {
        didSet {
            homeTeamLabel.text = homeTeamName
        }
    }

    var awayTeamName: String? {
        didSet {
            awayTeamLabel.text = awayTeamName
        }
    }
    
    var homeScoreName: String? {
        didSet {
            homeScoreLabel.text = homeScoreName
        }
    }

    var awayScoreName: String? {
        didSet {
            awayScoreLabel.text = awayScoreName
        }
    }

    private func formatTimestamp(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = .current
        return formatter.string(from: date)
    }
    
    var homeTeamImage: UIImage? {
        didSet {
            homeTeamImageView.image = homeTeamImage
        }
    }

    var awayTeamImage: UIImage? {
        didSet {
            awayTeamImageView.image = awayTeamImage
        }
    }

}

