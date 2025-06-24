import UIKit
import SnapKit
import SofaAcademic

final class IncidentDetailView: BaseView {
    private var sport: Sport?
    
    private let iconImageView = UIImageView()
    private let minuteLabel = UILabel()
    private let dividerView = UIView()
    private let playerNameLabel = UILabel()
    private let typeLabel = UILabel()
    private let scoreLabel = UILabel()
    private let basketballDividerView = UIView()
    
    private var iconLeadingConstraint: Constraint?
    private var iconTrailingConstraint: Constraint?
    private var dividerLeadingConstraint: Constraint?
    private var dividerTrailingConstraint: Constraint?
    private var playerNameLeadingConstraint: Constraint?
    private var playerNameTrailingConstraint: Constraint?
    private var scoreLabelLeadingConstraint: Constraint?
    private var scoreLabelTrailingConstraint: Constraint?
    private var playerNameTopConstraint: Constraint?
    private var playerNameCenterYConstraint: Constraint?
    private var typeLabelTopConstraint: Constraint?

    override func addViews() {
        [iconImageView, minuteLabel, dividerView,
         playerNameLabel, typeLabel, scoreLabel,
         basketballDividerView].forEach(addSubview)
    }

    override func styleViews() {
        backgroundColor = .white
        
        iconImageView.contentMode = .scaleAspectFit
        
        minuteLabel.font = .robotoRegular12
        minuteLabel.textColor = .customBlackGray
        minuteLabel.textAlignment = .center
        
        dividerView.backgroundColor = .customGray
        
        playerNameLabel.font = .robotoRegular14
        playerNameLabel.textColor = .customBlack
        
        typeLabel.font = .robotoRegular12
        typeLabel.textColor = .customBlackGray
        
        scoreLabel.font = .robotoBold20
        scoreLabel.textColor = .customBlack
        scoreLabel.isHidden = true
        
        basketballDividerView.backgroundColor = .customGray
        basketballDividerView.isHidden = true
    }

    override func setupConstraints() {
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.width.height.equalTo(24)
        }
        
        dividerView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.centerY.equalToSuperview()
        }
        
        scoreLabel.snp.makeConstraints {
            $0.centerY.equalTo(dividerView.snp.centerY)
        }
        
        playerNameLabel.snp.makeConstraints {
            playerNameTopConstraint = $0.top.equalToSuperview().offset(12).constraint
            playerNameCenterYConstraint = $0.centerY.equalTo(dividerView).constraint
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.leading.greaterThanOrEqualToSuperview().offset(16)
        }
        
        typeLabel.snp.makeConstraints {
            typeLabelTopConstraint = $0.top.equalTo(playerNameLabel.snp.bottom).offset(0).constraint
            $0.leading.trailing.equalTo(playerNameLabel)
            $0.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }

    func configure(with incident: Incident, sportName: Sport) {
        self.sport = sportName
        let isHomeTeam = incident.isHomeTeam ?? false
        let type = incident.type.rawValue
        
        configureForSport(sportName)
        configureIcon(for: type, scoreDiff: incident.scoreDiff)
        configureText(incident: incident, type: type, isHomeTeam: isHomeTeam)
        updateConstraints(isHomeTeam: isHomeTeam)
    }
    
    private func configureForSport(_ sport: Sport) {
        let isBasketball = sport == .basketball
        
        playerNameLabel.isHidden = isBasketball
        typeLabel.isHidden = isBasketball
        basketballDividerView.isHidden = !isBasketball
        
        if isBasketball {
            minuteLabel.snp.remakeConstraints {
                $0.center.equalToSuperview()
            }
            basketballDividerView.snp.remakeConstraints {
                $0.top.equalTo(minuteLabel.snp.bottom).offset(11)
                $0.width.equalTo(24)
                $0.height.equalTo(1)
                $0.centerX.equalTo(minuteLabel)
            }
            dividerView.isHidden = false
            scoreLabel.isHidden = false
        } else {
            minuteLabel.snp.remakeConstraints {
                $0.top.equalTo(iconImageView.snp.bottom).offset(2)
                $0.centerX.equalTo(iconImageView.snp.centerX)
                $0.bottom.lessThanOrEqualToSuperview().inset(8)
            }
            dividerView.isHidden = false
            scoreLabel.isHidden = false
            basketballDividerView.isHidden = true
        }
    }

    private func configureIcon(for type: String, scoreDiff: Int?) {
        iconImageView.isHidden = false
        
        switch type {
        case "GOAL":
            iconImageView.image = {
                switch scoreDiff {
                case 3: return UIImage(named: "three_points")
                case 2: return UIImage(named: "two_points")
                default: return UIImage(named: "goal_icon")
                }
            }()
        case "YELLOW_CARD":
            iconImageView.image = UIImage(named: "red_card")?.withRenderingMode(.alwaysOriginal)
        case "RED_CARD":
            iconImageView.image = UIImage(named: "red_card")?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = .redError
        default:
            iconImageView.isHidden = true
            iconImageView.image = nil
        }
    }

    private func configureText(incident: Incident, type: String, isHomeTeam: Bool) {
        playerNameLabel.text = incident.player ?? ""
        minuteLabel.text = incident.minute.map { "\($0)'" }
        
        let alignment: NSTextAlignment = isHomeTeam ? .left : .right
        playerNameLabel.textAlignment = alignment
        typeLabel.textAlignment = alignment
        scoreLabel.textAlignment = alignment
        
        switch type {
        case "GOAL":
            scoreLabel.text = incident.score
            scoreLabel.isHidden = false
            typeLabel.isHidden = true
        case "YELLOW_CARD", "RED_CARD":
            typeLabel.text = "Foul"
            typeLabel.isHidden = true
            scoreLabel.isHidden = true
            scoreLabel.text = nil
        default:
            typeLabel.text = type.capitalized
            typeLabel.isHidden = false
            scoreLabel.isHidden = true
            scoreLabel.text = nil
        }
        
        if typeLabel.isHidden {
            playerNameTopConstraint?.deactivate()
            typeLabelTopConstraint?.deactivate()
            playerNameCenterYConstraint?.activate()
        } else {
            playerNameCenterYConstraint?.deactivate()
            playerNameTopConstraint?.activate()
            typeLabelTopConstraint?.activate()
        }
    }
    
    private func updateConstraints(isHomeTeam: Bool) {
        [iconLeadingConstraint, iconTrailingConstraint,
         dividerLeadingConstraint, dividerTrailingConstraint,
         playerNameLeadingConstraint, playerNameTrailingConstraint,
         scoreLabelLeadingConstraint, scoreLabelTrailingConstraint]
        .forEach { $0?.deactivate() }
        
        guard let sport = self.sport else { return }
        let isBasketball = sport == .basketball
        
        if isBasketball {
            if isHomeTeam {
                iconImageView.snp.remakeConstraints {
                    iconLeadingConstraint = $0.leading.equalToSuperview().offset(16).constraint
                    $0.width.height.equalTo(24)
                    $0.top.equalToSuperview().offset(8)
                    $0.bottom.equalToSuperview().inset(8)
                }
                dividerView.snp.remakeConstraints {
                    dividerLeadingConstraint = $0.leading.equalTo(iconImageView.snp.trailing).offset(15).constraint
                    $0.width.equalTo(1)
                    $0.height.equalTo(24)
                    $0.centerY.equalTo(iconImageView.snp.centerY)
                }
                scoreLabel.snp.remakeConstraints {
                    scoreLabelLeadingConstraint = $0.leading.equalTo(dividerView.snp.trailing).offset(8).constraint
                    $0.centerY.equalTo(dividerView.snp.centerY)
                    $0.trailing.lessThanOrEqualToSuperview().inset(16)
                }
                playerNameLabel.isHidden = true
                typeLabel.isHidden = true
            } else {
                iconImageView.snp.remakeConstraints {
                    iconTrailingConstraint = $0.trailing.equalToSuperview().inset(16).constraint
                    $0.width.height.equalTo(24)
                    $0.top.equalToSuperview().offset(8)
                    $0.bottom.equalToSuperview().inset(8)
                }
                dividerView.snp.remakeConstraints {
                    dividerTrailingConstraint = $0.trailing.equalTo(iconImageView.snp.leading).offset(-15).constraint
                    $0.width.equalTo(1)
                    $0.height.equalTo(24)
                    $0.centerY.equalTo(iconImageView.snp.centerY)
                }
                scoreLabel.snp.remakeConstraints {
                    scoreLabelTrailingConstraint = $0.trailing.equalTo(dividerView.snp.leading).offset(-8).constraint
                    $0.centerY.equalTo(dividerView.snp.centerY)
                    $0.leading.greaterThanOrEqualToSuperview().offset(16)
                }
                playerNameLabel.isHidden = true
                typeLabel.isHidden = true
            }
        } else {
            if isHomeTeam {
                iconImageView.snp.remakeConstraints {
                    iconLeadingConstraint = $0.leading.equalToSuperview().offset(16).constraint
                    $0.top.equalToSuperview().offset(8)
                    $0.width.height.equalTo(24)
                }
                dividerView.snp.remakeConstraints {
                    dividerLeadingConstraint = $0.leading.equalTo(iconImageView.snp.trailing).offset(15).constraint
                    $0.centerY.equalToSuperview()
                    $0.width.equalTo(1)
                    $0.height.equalTo(40)
                }
                scoreLabel.snp.remakeConstraints {
                    scoreLabelLeadingConstraint = $0.leading.equalTo(dividerView.snp.trailing).offset(8).constraint
                    $0.centerY.equalTo(dividerView.snp.centerY)
                }
                playerNameLabel.snp.remakeConstraints {
                    playerNameLeadingConstraint = $0.leading.equalTo(scoreLabel.snp.trailing).offset(14).constraint
                    $0.trailing.lessThanOrEqualToSuperview().inset(16)
                    $0.centerY.equalTo(dividerView.snp.centerY)
                }
            } else {
                iconImageView.snp.remakeConstraints {
                    iconTrailingConstraint = $0.trailing.equalToSuperview().inset(16).constraint
                    $0.top.equalToSuperview().offset(8)
                    $0.width.height.equalTo(24)
                }
                dividerView.snp.remakeConstraints {
                    dividerTrailingConstraint = $0.trailing.equalTo(iconImageView.snp.leading).offset(-15).constraint
                    $0.centerY.equalToSuperview()
                    $0.width.equalTo(1)
                    $0.height.equalTo(40)
                }
                scoreLabel.snp.remakeConstraints {
                    scoreLabelTrailingConstraint = $0.trailing.equalTo(dividerView.snp.leading).offset(-8).constraint
                    $0.centerY.equalTo(dividerView.snp.centerY)
                }
                playerNameLabel.snp.remakeConstraints {
                    playerNameTrailingConstraint = $0.trailing.equalTo(scoreLabel.snp.leading).offset(-14).constraint
                    $0.leading.greaterThanOrEqualToSuperview().offset(16)
                    $0.centerY.equalTo(dividerView.snp.centerY)
                }
            }
        }
    }
}
