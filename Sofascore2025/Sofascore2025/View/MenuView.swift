import UIKit
import SnapKit
import Combine
import SofaAcademic

final class MenuView<T>: BaseView {
    private let menuStack = UIStackView()
    private let selectorView = UIView()
    private var menuItems: [MenuItemView] = []
    private var cancellables: Set<AnyCancellable> = []

    var onItemSelected: ((T) -> Void)?
    private var items: [T] = []
    private var selectedIndex: Int = 0

    private let titleProvider: (T) -> String
    private let imageProvider: ((T) -> String)?

    init(items: [T], titleProvider: @escaping (T) -> String, imageProvider: ((T) -> String)? = nil) {
        self.items = items
        self.titleProvider = titleProvider
        self.imageProvider = imageProvider
        super.init()
    }

    override func addViews() {
        menuStack.axis = .horizontal
        menuStack.distribution = .fillEqually
        menuStack.alignment = .fill
        menuStack.spacing = 0
        menuStack.backgroundColor = .customBlue

        addSubview(menuStack)
        menuStack.addSubview(selectorView)

        items.enumerated().forEach { index, item in
            let menuItem = MenuItemView()
                .setTitle(titleProvider(item))

            if let imageName = imageProvider?(item), !imageName.isEmpty {
                menuItem.setImage(imageName)
            } else {
                menuItem.hideImage()
            }

            menuItem.tapPublisher
                .sink { [weak self] in
                    self?.select(index: index)
                    self?.onItemSelected?(item)
                }
                .store(in: &cancellables)

            menuStack.addArrangedSubview(menuItem)
            menuItems.append(menuItem)
        }
    }

    override func styleViews() {
        selectorView.backgroundColor = .white
        selectorView.layer.cornerRadius = 2
        selectorView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    override func setupConstraints() {
        menuStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func select(index: Int) {
        guard index < menuItems.count else { return }
        selectedIndex = index
        layoutSelector(index: index)
    }

    private func layoutSelector(index: Int) {
        guard index < menuItems.count else { return }

        selectorView.snp.remakeConstraints {
            $0.height.equalTo(4)
            $0.bottom.equalToSuperview()
            $0.centerX.equalTo(menuItems[index].snp.centerX)
            $0.width.equalTo(menuItems[index].snp.width).offset(-16)
        }

        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSelector(index: selectedIndex)
    }
}
