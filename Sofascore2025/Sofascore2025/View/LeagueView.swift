//
//  LeagueView.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 12.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class LeagueView: UIView {

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }()

    let leagueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.alpha = 0.4
        return label
    }()

    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: ImageResource(name: "ic_pointer_right", bundle: .main))
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        addSubview(logoImageView)
        addSubview(countryLabel)
        addSubview(leagueLabel)
        addSubview(arrowImageView)

        logoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(12)
            make.width.height.equalTo(32)
        }

        countryLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(16)
            make.centerY.equalTo(logoImageView)
        }

        arrowImageView.snp.makeConstraints { make in
            make.left.equalTo(countryLabel.snp.right).offset(4)
            make.centerY.equalTo(countryLabel)
            make.width.height.equalTo(24)
        }

        leagueLabel.snp.makeConstraints { make in
            make.left.equalTo(arrowImageView.snp.right).offset(12)
            make.centerY.equalTo(countryLabel)
        }
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
