//
//  MainCollectionManager.swift
//  FashionApp
//
//  Created by Krasivo on 05.08.2023.
//

import UIKit

enum MainCollectionCellType {
    case addSquare
    case paywallSquare
    case templateSquare
}

protocol MainCollectionConfiguratorProtocol {
    var reuseId: String { get } // переменная для ячейки с reuse id
    var cellType: MainCollectionCellType { get } // тип ячейки для отработки нажатия
    var model: MainViewModel? { get set } // моделька ячейки
    func setupCell(_ cell: UIView) // конфиг ячейки
}

final class MainAddSquareConfigurator: MainCollectionConfiguratorProtocol {
    var reuseId: String { String(describing: AddCollectionViewCell.self) }
    var cellType: MainCollectionCellType = .addSquare
    var model: MainViewModel?
    
    func setupCell(_ cell: UIView) {}
}

final class MainPaywallSquareConfigurator: MainCollectionConfiguratorProtocol {
    var reuseId: String { String(describing: PaywallCollectionViewCell.self) }
    var cellType: MainCollectionCellType = .paywallSquare
    var model: MainViewModel?
    func setupCell(_ cell: UIView) {}
}

final class MainTemplateSquareConfigurator: MainCollectionConfiguratorProtocol {
    var reuseId: String { String(describing: TemplateCollectionViewCell.self) }
    var cellType: MainCollectionCellType = .templateSquare
    var model: MainViewModel?
    
    func setupCell(_ cell: UIView) {
//        guard let cell = cell as? TemplateCollectionViewCell,
//              let sectionModel = model else { return }
    }
}

protocol MainCollectionManagerDelegate: AnyObject {
    func addCellTapped()
    func paywallCellTapped()
    func templateCellTapped()
}

protocol MainCollectionManagerProtocol: AnyObject {
    func injectCollection(_ collectionView: UICollectionView)
    func injectDelegate(_ delegate: MainCollectionManagerDelegate)
    func displaySquareTemplates(_ results: [MainViewModel], isShowAddTemplate: Bool, isShowPaywallTemplate: Bool)
}

final class MainCollectionManager: NSObject, MainCollectionManagerProtocol {
    // MARK: - Private properties
    private var collectionView: UICollectionView?
    private var configuratorsDataSource: [MainCollectionConfiguratorProtocol] = []
    weak var delegate: MainCollectionManagerDelegate?
    
    // MARK: - Public functions
    func injectCollection(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.collectionViewLayout = collectionItemLayout()
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(AddCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AddCollectionViewCell.self))
        self.collectionView?.register(PaywallCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PaywallCollectionViewCell.self))
        self.collectionView?.register(TemplateCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TemplateCollectionViewCell.self))
    }
    
    func injectDelegate(_ delegate: MainCollectionManagerDelegate) {
        self.delegate = delegate
    }
    
    func displaySquareTemplates(_ results: [MainViewModel], isShowAddTemplate: Bool, isShowPaywallTemplate: Bool) {
        var output: [MainCollectionConfiguratorProtocol] = []
        
        if isShowAddTemplate {
            output.append(addTemplatesConfigurator())
        }
        
        if isShowAddTemplate {
            output.append(paywallConfigurator())
        }
        
        results.forEach({ viewModel in
            output.append(templatesListConfigurator(with: viewModel))
        })
        
        configuratorsDataSource = output.compactMap { $0 }
        collectionView?.reloadData()
    }
    
    // MARK: - Private functions
    
    private func addTemplatesConfigurator() -> MainCollectionConfiguratorProtocol {
        let configurator = MainAddSquareConfigurator()
        return configurator
    }
    
    private func paywallConfigurator() -> MainCollectionConfiguratorProtocol {
        let configurator = MainPaywallSquareConfigurator()
        return configurator
    }
    
    private func templatesListConfigurator(with model: MainViewModel) -> MainCollectionConfiguratorProtocol {
        let configurator = MainTemplateSquareConfigurator()
        configurator.model = model
        
        return configurator
    }
}

extension MainCollectionManager: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        configuratorsDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configurator = configuratorsDataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.reuseId,
                                                      for: indexPath)
        configurator.setupCell(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let configurator = configuratorsDataSource[indexPath.row]
        switch configurator.cellType {
        case .addSquare:
            delegate?.addCellTapped()
        case .paywallSquare:
            delegate?.paywallCellTapped()
        case .templateSquare:
            delegate?.templateCellTapped()
        }
    }
    
    func collectionItemLayout() -> UICollectionViewLayout {
        var estimatedHeight: CGFloat = 0
        var estimatedWidth: CGFloat = 0

        estimatedWidth = CGFloat(175).autoHeightSize
        estimatedHeight = CGFloat(250).autoHeightSize
        
       //estimatedWidth = //CGFloat(160)
       //estimatedHeight = // CGFloat(230)

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(estimatedWidth),
            heightDimension: .absolute(estimatedHeight)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: .fixed(8),
            top: .fixed(8),
            trailing: .fixed(8),
            bottom: .fixed(8)
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(estimatedHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        // Вычислите доступную ширину на экране вычитанием отступов слева и справа из ширины экрана
        let screenWidth = UIScreen.main.bounds.width
        let leadingInset: CGFloat = 12
        let trailingInset: CGFloat = 12
        let availableWidth = screenWidth - leadingInset - trailingInset

        // Вычтите общую ширину ячеек и промежутков из доступной ширины
        let cellSpacing: CGFloat = 8 // Промежуток между ячейками
        let totalCellWidth = estimatedWidth + cellSpacing
        let numberOfCellsInGroup = Int(availableWidth / totalCellWidth)
        let remainingWidth = availableWidth - (CGFloat(numberOfCellsInGroup) * totalCellWidth)

        // Измените горизонтальные отступы, чтобы центрировать группу ячеек
//        let horizontalInset = remainingWidth / 2
//
//        group.contentInsets = NSDirectionalEdgeInsets(
//            top: 0,
//            leading: horizontalInset,
//            bottom: 0,
//            trailing: horizontalInset
//        )
        
        let horizontalInset = (availableWidth - CGFloat(numberOfCellsInGroup) * estimatedWidth - CGFloat(numberOfCellsInGroup - 1) * cellSpacing) / 2

        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: horizontalInset,
            bottom: 0,
            trailing: horizontalInset
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

}
