import UIKit
import SnapKit
import SofaAcademic

final class PlayerManagerTableViewCell: UITableViewCell {
    private let playerImage = UIImageView()
    private let nameLabel = UILabel()
    private let countryLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        styleViews()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(playerImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countryLabel)
    }

    private func styleViews() {
        playerImage.contentMode = .scaleAspectFit
        playerImage.clipsToBounds = true
        playerImage.layer.cornerRadius = 20

        nameLabel.font = .robotoRegular14
        nameLabel.textColor = .customBlack

        countryLabel.font = .robotoBold12
        countryLabel.textColor = .customBlackGray
    }

    private func setupConstraints() {
        playerImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.lessThanOrEqualToSuperview().offset(-8)
            $0.size.equalTo(40)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(playerImage.snp.trailing).offset(16)
        }

        countryLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(playerImage.snp.trailing).offset(16)
        }
    }

    func configure(with manager: TeamManager) {
        nameLabel.text = manager.name
        countryLabel.text = manager.country?.name ?? ""

        if let url = URL(string: manager.imageUrl), !manager.imageUrl.isEmpty {
            playerImage.setImageURL(url)
        } else {
            playerImage.image = UIImage(named: "default_manager")
        }
    }

    func configure(with player: Player) {
        nameLabel.text = player.name
        countryLabel.text = player.country?.name ?? ""

        if let url = URL(string: player.imageUrl), !player.imageUrl.isEmpty {
            playerImage.setImageURL(url)
        } else {
            playerImage.image = UIImage(named: "default_player")
        }
    }
}
