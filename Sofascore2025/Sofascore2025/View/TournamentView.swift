import UIKit
import SnapKit
import SofaAcademic

class TournamentView: BaseView {
    private let logoImageView = UIImageView()
    private let nameLabel = UILabel()

    override func addViews() {
        addSubview(logoImageView)
        addSubview(nameLabel)
    }
    
    override func styleViews() {
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true

        nameLabel.font = .robotoRegular12
        nameLabel.textColor = .customBlackGray
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview().inset(12)
        }
    }

    func configure(with league: League) {
        nameLabel.text = league.name
        if let url = URL(string: league.logoUrl) {
            logoImageView.setImageURL(url)
        } else {
            logoImageView.image = UIImage(named: "default_logo")
        }
    }
}
