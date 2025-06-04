import UIKit
import SnapKit
import SofaAcademic

final class IncidentDetailView: BaseView {
    private let iconImageView = UIImageView()
    private let minuteLabel = UILabel()
    private let dividerView = UIView()
    private let playerNameLabel = UILabel()
    private let typeOrScoreLabel = UILabel()

    override func addViews() {
        addSubview(iconImageView)
        addSubview(minuteLabel)
        addSubview(dividerView)
        addSubview(playerNameLabel)
        addSubview(typeOrScoreLabel)
    }

    override func styleViews() {
        backgroundColor = .white

        iconImageView.contentMode = .scaleAspectFit

        minuteLabel.font = .robotoRegular12
        minuteLabel.textColor = .customBlackGray
        minuteLabel.textAlignment = .center

        dividerView.backgroundColor = .lightGray

        playerNameLabel.font = .robotoRegular12
        playerNameLabel.textColor = .black

        typeOrScoreLabel.font = .robotoRegular12
        typeOrScoreLabel.textColor = .darkGray
    }

    override func setupConstraints() {
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.width.height.equalTo(20)
            $0.leading.equalToSuperview().offset(18)
        }

        minuteLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(2)
            $0.centerX.equalTo(iconImageView.snp.centerX)
            $0.bottom.equalToSuperview().inset(8)
        }

        dividerView.snp.makeConstraints {
            $0.centerY.equalTo(iconImageView.snp.centerY)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(17)
            $0.width.equalTo(1)
            $0.height.equalTo(30)
        }

        playerNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(dividerView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(8)
        }

        typeOrScoreLabel.snp.makeConstraints {
            $0.top.equalTo(playerNameLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalTo(playerNameLabel)
            $0.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }

    func configure(with incident: Incident) {
        let isGoal = incident.type.rawValue == "GOAL"
        let isHomeTeam = incident.isHomeTeam ?? false

        iconImageView.image = isGoal ? UIImage(named: "goal_icon") : nil
        iconImageView.isHidden = !isGoal

        if let minute = incident.minute {
            minuteLabel.text = "\(minute)'"
        } else {
            minuteLabel.text = nil
        }

        playerNameLabel.text = incident.player ?? ""
        playerNameLabel.textColor = .customBlack
        playerNameLabel.textAlignment = isHomeTeam ? .left : .right

        if isGoal, let score = incident.score {
            typeOrScoreLabel.text = "(\(score))"
            typeOrScoreLabel.textAlignment = playerNameLabel.textAlignment
        } else {
            typeOrScoreLabel.text = incident.type.rawValue.capitalized
            typeOrScoreLabel.textAlignment = .left
        }

        typeOrScoreLabel.textColor = .darkGray
    }
}
