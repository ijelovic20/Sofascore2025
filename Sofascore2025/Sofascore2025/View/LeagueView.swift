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

    private let containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        return view
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoBold14
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private let leagueLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoRegular14
        label.textAlignment = .left
        label.textColor = .black
        label.alpha = 0.4
        return label
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: ImageResource(name: "ic_pointer_right", bundle: .main))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(countryLabel)
        containerView.addSubview(leagueLabel)
        containerView.addSubview(arrowImageView)
    }
    
    override func styleViews() {
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
