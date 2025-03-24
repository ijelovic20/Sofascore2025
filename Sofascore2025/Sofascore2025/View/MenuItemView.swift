//
//  MenuItemView.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 21.03.2025..
//

import UIKit
import SnapKit

class MenuItemView: UIView {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    init(text: String, image: String) {
        super.init(frame: .zero)
        setupUI()
        configure(imageName: image, title: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.centerX.equalTo(imageView)
        }
        
        titleLabel.font = .robotoRegular14
        titleLabel.textColor = .white
    }

    private func configure(imageName: String, title: String) {
        imageView.image = UIImage(named: imageName)
        titleLabel.text = title
    }
}
