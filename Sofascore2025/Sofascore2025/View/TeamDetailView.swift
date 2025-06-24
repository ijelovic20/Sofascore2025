import UIKit
import SnapKit
import SofaAcademic

class TeamDetailView: BaseView {
    private let teamInfoLabel = UILabel()
    private let managerImageView = UIImageView()
    private let managerNameLabel = UILabel()
    private let managerCountryLabel = UILabel()
    private let teamsIconView = UIImageView()
    private let playerCountLabel = UILabel()
    private let pieChartContainerView = UIView()
    private let pieChartLayer = CAShapeLayer()
    private let foreignPlayerCountLabel = UILabel()
    private let totalPlayersLabel = UILabel()
    private let foreignPlayersLabel = UILabel()
    private let tournamentsLabel = UILabel()
    private let tournamentsContainerStackView = UIStackView()
    private let venueLabel = UILabel()
    private let stadiumLabel = UILabel()
    private let stadiumInfoLabel = UILabel()

    override func addViews() {
        addSubview(teamInfoLabel)
        addSubview(managerImageView)
        addSubview(managerNameLabel)
        addSubview(managerCountryLabel)
        addSubview(teamsIconView)
        addSubview(playerCountLabel)
        addSubview(pieChartContainerView)
        addSubview(foreignPlayerCountLabel)
        addSubview(totalPlayersLabel)
        addSubview(foreignPlayersLabel)
        addSubview(tournamentsLabel)
        addSubview(tournamentsContainerStackView)
        addSubview(venueLabel)
        addSubview(stadiumLabel)
        addSubview(stadiumInfoLabel)
    }

    override func styleViews() {
        backgroundColor = .white
        teamInfoLabel.text = "Team Info"
        tournamentsLabel.text = "Tournaments"
        venueLabel.text = "Venue"
        stadiumLabel.text = "Stadium"
        
        [teamInfoLabel, tournamentsLabel, venueLabel].forEach {
            $0.textColor = .customBlack
            $0.font = .robotoBold16
        }

        managerImageView.contentMode = .scaleAspectFill
        managerImageView.clipsToBounds = true
        managerImageView.layer.cornerRadius = 20
        
        [managerNameLabel, stadiumLabel, stadiumInfoLabel].forEach {
            $0.font = .robotoRegular14
            $0.textColor = .customBlack
        }
        
        managerCountryLabel.font = .robotoBold12
        managerCountryLabel.textColor = .customBlackGray
        
        teamsIconView.image = UIImage(named: "team")
        teamsIconView.contentMode = .scaleAspectFit

        playerCountLabel.font = .robotoBold14
        playerCountLabel.textColor = .customBlue

        pieChartContainerView.layer.addSublayer(pieChartLayer)
        pieChartContainerView.backgroundColor = .clear
        
        foreignPlayerCountLabel.font = .robotoBold14
        foreignPlayerCountLabel.textColor = .customBlue
        
        totalPlayersLabel.font = .robotoRegular12
        totalPlayersLabel.textColor = .customBlackGray
        totalPlayersLabel.text = "Total Players"
        
        foreignPlayersLabel.font = .robotoRegular12
        foreignPlayersLabel.textColor = .customBlackGray
        foreignPlayersLabel.text = "Foreign Players"

        tournamentsContainerStackView.axis = .vertical
        tournamentsContainerStackView.spacing = 12
        tournamentsContainerStackView.distribution = .fillEqually
    }

    override func setupConstraints() {
        teamInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }

        managerImageView.snp.makeConstraints {
            $0.top.equalTo(teamInfoLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(40)
        }

        managerNameLabel.snp.makeConstraints {
            $0.top.equalTo(teamInfoLabel.snp.bottom).offset(22)
            $0.leading.equalTo(managerImageView.snp.trailing).offset(16)
        }
        
        managerCountryLabel.snp.makeConstraints {
            $0.top.equalTo(managerNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(managerImageView.snp.trailing).offset(16)
        }
        
        teamsIconView.snp.makeConstraints {
            $0.top.equalTo(managerImageView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview().multipliedBy(0.5)
            $0.size.equalTo(40)
        }

        playerCountLabel.snp.makeConstraints {
            $0.top.equalTo(teamsIconView.snp.bottom).offset(8)
            $0.centerX.equalTo(teamsIconView)
        }
        
        pieChartContainerView.snp.makeConstraints {
            $0.top.equalTo(managerImageView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview().multipliedBy(1.5)
            $0.size.equalTo(40)
        }
        
        foreignPlayerCountLabel.snp.makeConstraints {
            $0.top.equalTo(pieChartContainerView.snp.bottom).offset(8)
            $0.centerX.equalTo(pieChartContainerView)
        }
        
        totalPlayersLabel.snp.makeConstraints {
            $0.top.equalTo(playerCountLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(playerCountLabel)
        }
        
        foreignPlayersLabel.snp.makeConstraints {
            $0.top.equalTo(foreignPlayerCountLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(foreignPlayerCountLabel)
        }
        
        tournamentsLabel.snp.makeConstraints {
            $0.top.equalTo(foreignPlayersLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        tournamentsContainerStackView.snp.makeConstraints {
            $0.top.equalTo(tournamentsLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview().inset(16)
        }
        
        venueLabel.snp.makeConstraints {
            $0.top.equalTo(tournamentsContainerStackView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        stadiumLabel.snp.makeConstraints {
            $0.top.equalTo(venueLabel).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        stadiumInfoLabel.snp.makeConstraints {
            $0.top.equalTo(venueLabel).offset(20)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }

    func configure(with info: TeamInfo) {
        if let manager = info.manager {
            managerNameLabel.text = "Coach:  \(manager.name)"
            managerCountryLabel.text = manager.country?.name ?? ""
            let imageUrlString = manager.imageUrl
            
            if let url = URL(string: imageUrlString), !imageUrlString.isEmpty {
                managerImageView.setImageURL(url)
            } else {
                managerImageView.image = UIImage(named: "default_manager")
            }
        } else {
            print("Manager info is nil")
            managerNameLabel.text = "No manager info"
            managerImageView.image = UIImage(named: "default_manager")
        }
        stadiumInfoLabel.text = info.venue?.name
    }
    
    func setPlayerCount(_ count: Int) {
        playerCountLabel.text = "\(count)"
    }
    
    func setForeignPlayerRatio(foreignCount: Int, total: Int) {
        pieChartLayer.sublayers?.forEach { $0.removeFromSuperlayer() }

        guard total > 0 else {
            foreignPlayerCountLabel.text = "0"
            return
        }

        foreignPlayerCountLabel.text = "\(foreignCount)"

        let size: CGFloat = 40
        pieChartLayer.frame = CGRect(x: 0, y: 0, width: size, height: size)

        let radius: CGFloat = size / 2 - 4
        let center = CGPoint(x: size / 2, y: size / 2)
        let lineWidth: CGFloat = 8

        let backgroundCircle = CAShapeLayer()
        backgroundCircle.path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: 0,
            endAngle: 2 * .pi,
            clockwise: true
        ).cgPath
        backgroundCircle.strokeColor = UIColor.customYellowGreen.cgColor
        backgroundCircle.fillColor = UIColor.clear.cgColor
        backgroundCircle.lineWidth = lineWidth
        pieChartLayer.addSublayer(backgroundCircle)

        let percentage = CGFloat(foreignCount) / CGFloat(total)
        let endAngle = 2 * .pi * percentage

        let foreignLayer = CAShapeLayer()
        foreignLayer.path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -.pi / 2,
            endAngle: endAngle - .pi / 2,
            clockwise: true
        ).cgPath
        foreignLayer.strokeColor = UIColor.customBlue.cgColor
        foreignLayer.fillColor = UIColor.clear.cgColor
        foreignLayer.lineWidth = lineWidth
        pieChartLayer.addSublayer(foreignLayer)
    }
    
    func configureTournaments(_ leagues: [League]) {
        tournamentsContainerStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard !leagues.isEmpty else { return }
        
        let maxItemsPerRow = 3
        var currentRowStackView: UIStackView?
        
        for (index, league) in leagues.enumerated() {
            if index % maxItemsPerRow == 0 {
                let rowStack = UIStackView()
                rowStack.axis = .horizontal
                rowStack.distribution = .fillEqually
                tournamentsContainerStackView.addArrangedSubview(rowStack)
                currentRowStackView = rowStack
            }
            
            let tournamentView = TournamentView()
            tournamentView.configure(with: league)
            currentRowStackView?.addArrangedSubview(tournamentView)
            
            let isLastInRow = (index % maxItemsPerRow == maxItemsPerRow - 1)
            let isLastElementOverall = (index == leagues.count - 1)
            
            if isLastElementOverall && !isLastInRow {
                let itemsInCurrentRow = (index % maxItemsPerRow) + 1
                let emptySpaces = maxItemsPerRow - itemsInCurrentRow
                
                for _ in 0..<emptySpaces {
                    let spacer = UIView()
                    spacer.backgroundColor = .clear
                    currentRowStackView?.addArrangedSubview(spacer)
                }
            }
        }
    }
}
