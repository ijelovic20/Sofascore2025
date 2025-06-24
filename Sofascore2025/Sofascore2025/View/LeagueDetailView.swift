import UIKit
import SofaAcademic
import Combine
import SnapKit

class LeagueDetailView: BaseView {
    let backButtonTappedPublisher = PassthroughSubject<Void, Never>()
    
    private let headerViewContainer = UIView()
    private let backButton = UIImageView()
    private let logoContainerView = UIView()
    private let leagueLogo = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private var titleTopConstraint: Constraint?
    
    override func addViews() {
        addSubview(headerViewContainer)
        headerViewContainer.addSubview(backButton)
        headerViewContainer.addSubview(logoContainerView)
        logoContainerView.addSubview(leagueLogo)
        headerViewContainer.addSubview(titleLabel)
        headerViewContainer.addSubview(subtitleLabel)
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
        logoContainerView.layer.masksToBounds = true
        
        titleLabel.font = .robotoBold20
        titleLabel.textColor = .customWhite
        titleLabel.numberOfLines = 0
        
        subtitleLabel.font = .robotoBold14
        subtitleLabel.textColor = .customWhite
        subtitleLabel.numberOfLines = 0
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

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(logoContainerView.snp.trailing).offset(12)
            self.titleTopConstraint = $0.top.equalTo(logoContainerView.snp.top).offset(4).constraint
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20)
        }
    }

    func configure(with viewModel: HeaderViewModel) {
        if let url = URL(string: viewModel.imageUrl) {
            leagueLogo.setImageURL(url)
        }
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }

    @objc func backButtonTapped() {
        backButtonTappedPublisher.send(())
    }

    func updateHeader(for scrollOffset: CGFloat) {
        let maxOffset: CGFloat = 60
        let offset = min(max(scrollOffset, 0), maxOffset)
        let fade = max(0, 1 - offset / maxOffset)

        titleTopConstraint?.update(offset: max(4 - offset, backButton.frame.minY - titleLabel.frame.minY))

        logoContainerView.alpha = fade
        leagueLogo.alpha = fade
        subtitleLabel.alpha = fade
    }
}
