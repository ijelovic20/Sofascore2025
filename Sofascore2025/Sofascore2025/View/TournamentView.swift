class TournamentView: UIView {
    private let logoImageView = UIImageView()
    private let nameLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(logoImageView)
        addSubview(nameLabel)

        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true

        nameLabel.font = .robotoRegular12
        nameLabel.textColor = .customBlack
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
    }

    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(40)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }

    func configure(with league: League) {
        nameLabel.text = league.name
        if let url = URL(string: league.logoUrl) {
            logoImageView.setImageURL(url) // pretpostavljam da imaš ekstenziju ili helper za async load slika
        } else {
            logoImageView.image = UIImage(named: "default_logo")
        }
    }
}
