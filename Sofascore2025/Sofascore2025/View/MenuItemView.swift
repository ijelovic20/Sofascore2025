//
//  MenuItemView.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 21.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic
import Combine

final class MenuItemView: BaseView {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    private let tapSubject = PassthroughSubject<Void, Never>()
    
    var tapPublisher: AnyPublisher<Void, Never> {
        return tapSubject.eraseToAnyPublisher()
    }

    override func addViews() {
        addSubview(imageView)
        addSubview(titleLabel)
    }

    override func styleViews() {
        titleLabel.font = .robotoRegular14
        titleLabel.textColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    override func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.centerX.equalTo(imageView)
        }
    }

    @objc private func handleTap() {
        tapSubject.send(())
    }
}

// MARK: - Public methods
extension MenuItemView {
    @discardableResult
    func setTitle(_ text: String) -> Self {
        titleLabel.text = text
        return self
    }

    @discardableResult
    func setImage(_ imageName: String) -> Self {
        imageView.image = UIImage(named: imageName)
        return self
    }
}
