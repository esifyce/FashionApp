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
    func setupCell(_ cell: UIView) // конфиг ячейки
}

final class MainAddSquareConfigurator: MainCollectionConfiguratorProtocol {
    var reuseId: String { String(describing: AddCollectionViewCell.self) }
    var cellType: MainCollectionCellType = .addSquare

    func setupCell(_ cell: UIView) {}
}

final class MainPaywallSquareConfigurator: MainCollectionConfiguratorProtocol {
    var reuseId: String { String(describing: PaywallCollectionViewCell.self) }
    var cellType: MainCollectionCellType = .paywallSquare
    
    func setupCell(_ cell: UIView) {}
}

final class MainTemplateSquareConfigurator: MainCollectionConfiguratorProtocol {
    var reuseId: String { String(describing: TemplateCollectionViewCell.self) }
    var cellType: MainCollectionCellType = .templateSquare
    var model: MainViewModel?
    var showActionSheetCallback: (() -> Void)?

    func setupCell(_ cell: UIView) {
        guard let cell = cell as? TemplateCollectionViewCell else { return }
        cell.configure(with: model)
        cell.showActionSheetCallback = showActionSheetCallback
    }
}

protocol MainCollectionManagerDelegate: AnyObject {
    func addCellTapped()
    func paywallCellTapped()
    func templateCellTapped()
    func moreTapped(with model: MainViewModel)
}

protocol MainCollectionManagerProtocol: AnyObject {
    func injectCollection(_ collectionView: UICollectionView)
    func injectDelegate(_ delegate: MainCollectionManagerDelegate)
    func displaySquareTemplates(_ results: [MainViewModel], isShowAddTemplate: Bool, isShowPaywallTemplate: Bool)
    func updateLayout(with traitCollection: UITraitCollection)
}

final class MainCollectionManager: NSObject, MainCollectionManagerProtocol {
    // MARK: - Private properties
    private var collectionView: UICollectionView?
    private var configuratorsDataSource: [MainCollectionConfiguratorProtocol] = []
    weak var delegate: MainCollectionManagerDelegate?
    
    // MARK: - Public functions
    func injectCollection(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.collectionViewLayout = UICollectionViewLayout()
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(AddCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AddCollectionViewCell.self))
        self.collectionView?.register(PaywallCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PaywallCollectionViewCell.self))
        self.collectionView?.register(TemplateCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TemplateCollectionViewCell.self))
    }
    
    func updateLayout(with traitCollection: UITraitCollection) {
        var layout: UICollectionViewLayout = UICollectionViewLayout()
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation.isLandscape {
                layout = IpadCollectionViewLayout.createLandscapeLayout()
            } else {
                layout = IpadCollectionViewLayout.createPortraitLayout()
            }
        } else {
            layout = IphoneCollectionViewLayout.createLayout()
        }
        
        collectionView?.collectionViewLayout = layout
        if !configuratorsDataSource.isEmpty {
            collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
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
        configurator.showActionSheetCallback = { [weak self] in
            self?.delegate?.moreTapped(with: model)
        }
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
}
