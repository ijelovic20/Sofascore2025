//
//  MatchView.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 13.03.2025..
//

import UIKit
import SnapKit

class MatchView: UIView {

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        addSubview(homeTeamLabel)
        addSubview(awayTeamLabel)

        homeTeamLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
        }

        awayTeamLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(homeTeamLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }

        //layer.borderColor = UIColor.black.cgColor
        //layer.borderWidth = 1
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
}
