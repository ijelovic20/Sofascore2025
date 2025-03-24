//
//  Menu.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 21.03.2025..
//

import UIKit
import SnapKit

class Menu: UIView {
    private var menuStack: UIStackView!
    private var selectorView: UIView!
    private var menuItems: [MenuItemView] = []

    override func didMoveToSuperview() {
        createViews()
        layoutViews()
    }

    private func createViews() {
        menuStack = UIStackView()
        menuStack.distribution = .fillEqually
        menuStack.backgroundColor = .systemBlue

        let items = [
            ("Football", "ic_sport_notif_Football"),
            ("Basketball", "ic_sport_notif_basketball"),
            ("Am. Football", "ic_sport_notif_american_Football")
        ]

        for (text, image) in items {
            let item = MenuItemView(text: text, image: image)
            item.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(menuItemTapped(_:)))
            item.addGestureRecognizer(tap)
            menuStack.addArrangedSubview(item)
            menuItems.append(item)
        }
        selectorView = UIView()
        selectorView.backgroundColor = .white
        menuStack.addSubview(selectorView)

        addSubview(menuStack)
    }

    private func layoutViews() {
        menuStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        layoutSelector(index: 0)
    }

    private func layoutSelector(index: Int) {
        selectorView.layer.cornerRadius = 2
        selectorView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        selectorView.snp.remakeConstraints { make in
            make.height.equalTo(4)
            make.bottom.equalToSuperview()
            make.left.equalTo(menuItems[index].snp.left).offset(8)
            make.right.equalTo(menuItems[index].snp.right).inset(8)
        }
    }

    @objc private func menuItemTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedItem = sender.view as? MenuItemView,
              let index = menuItems.firstIndex(of: tappedItem) else { return }
        layoutSelector(index: index)
    }
}
