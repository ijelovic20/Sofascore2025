import UIKit
import SnapKit
import SofaAcademic
import Combine

class MenuView: BaseView {
    private let menuStack = UIStackView()
    private let selectorView = UIView()
    private var menuItems: [MenuItemView] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    var onSportSelected: ((Sport) -> Void)?

    override func addViews() {
        menuStack.distribution = .fillEqually
        menuStack.backgroundColor = .customBlue
        
        for sport in Sport.allCases {
            let item = MenuItemView()
                .setTitle(sport.rawValue)
                .setImage(sport.iconName)

            item.tapPublisher
                .sink { [weak self] in
                    self?.menuItemTapped(item, sport: sport)
            }
            .store(in: &cancellables)
            
            menuStack.addArrangedSubview(item)
            menuItems.append(item)
        }

        selectorView.backgroundColor = .white
        menuStack.addSubview(selectorView)
        
        addSubview(menuStack)
    }

    override func styleViews() {
        selectorView.layer.cornerRadius = 2
        selectorView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    override func setupConstraints() {
        menuStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        layoutSelector(index: 0)
        
        selectorView.snp.remakeConstraints { make in
            make.height.equalTo(4)
            make.bottom.equalToSuperview()
            make.left.equalTo(menuItems[0].snp.left).offset(8)
            make.right.equalTo(menuItems[0].snp.right).inset(8)
        }
    }
    
    private func layoutSelector(index: Int) {
        selectorView.snp.remakeConstraints { make in
            make.height.equalTo(4)
            make.bottom.equalToSuperview()
            make.left.equalTo(menuItems[index].snp.left).offset(8)
            make.right.equalTo(menuItems[index].snp.right).inset(8)
        }
    }

    private func menuItemTapped(_ item: MenuItemView, sport: Sport) {
        guard let index = menuItems.firstIndex(of: item) else { return }
        layoutSelector(index: index)
        
        onSportSelected?(sport)
    }
}
