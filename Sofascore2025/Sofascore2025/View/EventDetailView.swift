import UIKit
import SofaAcademic

class EventDetailView: BaseView {

    private let event: EventViewModel
    private let league: LeagueViewModel
    
    var sportName: String

    private let headerContainerView = UIView()
    private let backButton = UIImageView()
    private let leagueLogo = UIImageView()
    private let detailLabel = UILabel()
    private let homeTeamImage = UIImageView()
    private let awayTeamImage = UIImageView()
    private let homeTeamName = UILabel()
    private let awayTeamName = UILabel()
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    private let dividerLabel = UILabel()
    private let statusLabel = UILabel()

    init(event: EventViewModel, league: LeagueViewModel, sportName: String) {
        self.event = event
        self.league = league
        self.sportName = sportName
        super.init()
    }

    override func addViews() {
        addSubview(headerContainerView)
        
        headerContainerView.addSubview(backButton)
        headerContainerView.addSubview(leagueLogo)
        headerContainerView.addSubview(detailLabel)
        
        addSubview(homeTeamImage)
        addSubview(awayTeamImage)
        addSubview(homeTeamName)
        addSubview(awayTeamName)
        addSubview(dateLabel)
        addSubview(timeLabel)
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
        addSubview(dividerLabel)
        addSubview(statusLabel)
    }

    override func styleViews() {
        backButton.image = UIImage(named: "Vector")
        backButton.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backButton.addGestureRecognizer(tapGesture)
        
        detailLabel.alpha = 0.4
        
        detailLabel.font = .robotoRegular12
        homeTeamName.font = .robotoBold12
        awayTeamName.font = .robotoBold12
        dateLabel.font = .robotoRegular12
        timeLabel.font = .robotoRegular12
        
        dateLabel.textAlignment = .center
        timeLabel.textAlignment = .center
        homeScoreLabel.textAlignment = .right
        awayScoreLabel.textAlignment = .left
        dividerLabel.textAlignment = .center
        statusLabel.textAlignment = .center
        
        dateLabel.textColor = .customBlack
        timeLabel.textColor = .customBlack
        homeScoreLabel.textColor = .customRed
        awayScoreLabel.textColor = .customRed
        dividerLabel.textColor = .customRed
        statusLabel.textColor = .customRed
        
        homeScoreLabel.font = .robotoBold32
        awayScoreLabel.font = .robotoBold32
        dividerLabel.font = .robotoBold32
        statusLabel.font = .robotoRegular12
    }

    override func setupConstraints() {
        headerContainerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }
        
        leagueLogo.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(24)
            $0.centerY.equalTo(backButton)
            $0.size.equalTo(16)
        }
        
        detailLabel.snp.makeConstraints {
            $0.leading.equalTo(leagueLogo.snp.trailing).offset(8)
            $0.centerY.equalTo(leagueLogo)
        }
        
        homeTeamImage.snp.makeConstraints {
            $0.top.equalTo(headerContainerView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(44)
            $0.size.equalTo(40)
        }
        
        homeTeamName.snp.makeConstraints{
            $0.top.equalTo(homeTeamImage.snp.bottom).offset(8)
            $0.centerX.equalTo(homeTeamImage)
            $0.height.equalTo(32)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(headerContainerView.snp.bottom).offset(24)
            $0.width.equalTo(136)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.centerX.equalTo(dateLabel)
            $0.width.equalTo(136)
        }
        
        awayTeamImage.snp.makeConstraints {
            $0.top.equalTo(headerContainerView.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().offset(-44)
            $0.size.equalTo(40)
        }
        
        awayTeamName.snp.makeConstraints{
            $0.top.equalTo(awayTeamImage.snp.bottom).offset(8)
            $0.centerX.equalTo(awayTeamImage)
            $0.height.equalTo(32)
        }
        
        dividerLabel.snp.makeConstraints {
            $0.top.equalTo(headerContainerView.snp.bottom).offset(16)
            $0.centerX.equalTo(headerContainerView)
            $0.width.equalTo(16)
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(dividerLabel.snp.bottom)
            $0.centerX.equalTo(dividerLabel)
            $0.width.equalTo(72)
        }
        
        homeScoreLabel.snp.makeConstraints {
            $0.trailing.equalTo(dividerLabel.snp.leading).offset(-4)
            $0.centerY.equalTo(dividerLabel)
            $0.width.equalTo(56)
        }
        
        awayScoreLabel.snp.makeConstraints {
            $0.leading.equalTo(dividerLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(dividerLabel)
            $0.width.equalTo(56)
        }
    }
    
    func configure(with event: EventViewModel, league: LeagueViewModel) {
        if let logoUrl = league.logoURL {
            leagueLogo.setImageURL(logoUrl)
        }
        
        if let homeURL = event.homeTeamLogoURL {
            homeTeamImage.setImageURL(homeURL)
        }
        
        if let awayURL = event.awayTeamLogoURL {
            awayTeamImage.setImageURL(awayURL)
        }
        
        detailLabel.text = "\(sportName), \(league.countryName), \(league.leagueName), Round 15"
        homeTeamName.text = event.homeTeamName
        awayTeamName.text = event.awayTeamName
        
        switch event.matchStatus {
            case "NOT_STARTED":
                dateLabel.text = Self.formatDate(timestamp: event.startTimestamp)
                timeLabel.text = event.formattedTime
            case "IN_PROGRESS":
                homeScoreLabel.text = event.homeScoreText
                dividerLabel.text = "-"
                awayScoreLabel.text = event.awayScoreText
                statusLabel.text = event.matchMinute.map { "\($0)'" } ?? ""
            case "FINISHED":
                homeScoreLabel.text = event.homeScoreText
                dividerLabel.text = "-"
                awayScoreLabel.text = event.awayScoreText
                statusLabel.text = "Full Time"
            
                statusLabel.alpha = 0.4
                homeScoreLabel.alpha = event.homeAlpha
                awayScoreLabel.alpha = event.awayAlpha
                dividerLabel.alpha = 0.4
            
                homeScoreLabel.textColor = .customBlack
                awayScoreLabel.textColor = .customBlack
                dividerLabel.textColor = .customBlack
                statusLabel.textColor = .customBlack
            case "HALF_TIME":
                dateLabel.text = "HT \(event.homeScoreText) : \(event.awayScoreText)"
                detailLabel.textColor = .customRed
                detailLabel.alpha = 1.0
        default:
            print("NE!")
        }
    }

    @objc func backButtonTapped() {
        if let navigationController = self.findNavigationController() {
            navigationController.popViewController(animated: true)
        }
    }

    private func findNavigationController() -> UINavigationController? {
        var responder = self.next
        while let nextResponder = responder {
            if let navigationController = nextResponder as? UINavigationController {
                return navigationController
            }
            responder = nextResponder.next
        }
        return nil
    }
    
    private static func formatDate(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}
