import UIKit
import SofaAcademic
import Combine

class LeagueDetailView: BaseView {
    let backButtonTappedPublisher = PassthroughSubject<Void, Never>()
    
    private let headerViewContainer = UIView()
    private let backButton = UIImageView()
    private let logoContainerView = UIView()
    private let leagueLogo = UIImageView()
    private let leagueNameLabel = UILabel()
    private let countryNameLabel = UILabel()
    
    override func addViews() {
        addSubview(headerViewContainer)
        
        headerViewContainer.addSubview(backButton)
        headerViewContainer.addSubview(logoContainerView)
        logoContainerView.addSubview(leagueLogo)
        headerViewContainer.addSubview(leagueNameLabel)
        headerViewContainer.addSubview(countryNameLabel)
    }

    override func styleViews() {
        backgroundColor = .white
        
        headerViewContainer.backgroundColor = .customBlue
        
        backButton.image = UIImage(named: "Vector")?.withRenderingMode(.alwaysTemplate)
        backButton.tintColor = .customWhite
        backButton.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backButton.addGestureRecognizer(tapGesture)
        
        logoContainerView.backgroundColor = .customWhite
        logoContainerView.layer.cornerRadius = 8
        
        leagueNameLabel.font = .robotoBold20
        leagueNameLabel.textColor = .customWhite
        
        countryNameLabel.font = .robotoBold14
        countryNameLabel.textColor = .customWhite
    }

    override func setupConstraints() {
        headerViewContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(16)
        }
        
        logoContainerView.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(56)
        }
        
        leagueLogo.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        leagueNameLabel.snp.makeConstraints {
            $0.leading.equalTo(logoContainerView.snp.trailing).offset(12)
            $0.top.equalTo(logoContainerView.snp.top).offset(4)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        countryNameLabel.snp.makeConstraints {
            $0.leading.equalTo(leagueNameLabel)
            $0.top.equalTo(leagueNameLabel.snp.bottom).offset(4)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    func configure(league: League) {
        if let url = URL(string: league.logoUrl) {
            leagueLogo.setImageURL(url)
        }
        
        leagueNameLabel.text = league.name
        countryNameLabel.text = league.country.name
    }

    @objc func backButtonTapped() {
        backButtonTappedPublisher.send(())
    }
}
