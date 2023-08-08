//
//  TemplateCollectionManager.swift
//  FashionApp
//
//  Created by Krasivo on 08.08.2023.
//

import UIKit

enum TemplateCollectionCellType {
    case templateSquare
}

protocol TemplateCollectionConfiguratorProtocol {
    var reuseId: String { get } // переменная для ячейки с reuse id
    var cellType: TemplateCollectionCellType { get } // тип ячейки для отработки нажатия
    func setupCell(_ cell: UIView) // конфиг ячейки
}

final class TemplateSquareConfigurator: TemplateCollectionConfiguratorProtocol {
    var reuseId: String { String(describing: TemplateCollectionViewCell.self) }
    var cellType: TemplateCollectionCellType = .templateSquare
    var model: MainViewModel?
    var showActionSheetCallback: (() -> Void)?

    func setupCell(_ cell: UIView) {
        guard let cell = cell as? TemplateCollectionViewCell else { return }
        cell.showActionSheetCallback = showActionSheetCallback
    }
}

protocol TemplateCollectionManagerDelegate: AnyObject {
    func templateCellTapped()
    func moreTapped()
}

protocol TemplateCollectionManagerProtocol: AnyObject {
    func injectCollection(_ collectionView: UICollectionView)
    func injectDelegate(_ delegate: TemplateCollectionManagerDelegate)
    func displaySquareTemplates(_ results: [MainViewModel])
    func updateLayout(with traitCollection: UITraitCollection)
}

final class TemplateCollectionManager: NSObject, TemplateCollectionManagerProtocol {
    // MARK: - Private properties
    private var collectionView: UICollectionView?
    private var configuratorsDataSource: [TemplateCollectionConfiguratorProtocol] = []
    weak var delegate: TemplateCollectionManagerDelegate?
    
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
    
    func injectDelegate(_ delegate: TemplateCollectionManagerDelegate) {
        self.delegate = delegate
    }
    
    func displaySquareTemplates(_ results: [MainViewModel]) {
        var output: [TemplateCollectionConfiguratorProtocol] = []
        
        results.forEach({ viewModel in
            output.append(templatesListConfigurator(with: viewModel))
        })
        
        configuratorsDataSource = output.compactMap { $0 }
        collectionView?.reloadData()
    }
    
    // MARK: - Private functions
    
    private func templatesListConfigurator(with model: MainViewModel) -> TemplateCollectionConfiguratorProtocol {
        let configurator = TemplateSquareConfigurator()
        configurator.model = model
        configurator.showActionSheetCallback = { [weak self] in
            self?.delegate?.moreTapped()
        }
        return configurator
    }
}

extension TemplateCollectionManager: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        configuratorsDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configurator = configuratorsDataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.reuseId, for: indexPath)
        configurator.setupCell(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let configurator = configuratorsDataSource[indexPath.row]
        switch configurator.cellType {
        case .templateSquare:
            delegate?.templateCellTapped()
        }
    }
}
