//
//  LayersCollectionManager.swift
//  FashionApp
//
//  Created by Krasivo on 21.08.2023.
//

import UIKit

enum LayersCollectionCellType {
    case layerSquare
}

protocol LayersCollectionConfiguratorProtocol {
    var reuseId: String { get } // переменная для ячейки с reuse id
    var cellType: LayersCollectionCellType { get } // тип ячейки для отработки нажатия
    var model: LayerViewModel? { get set } // моделька
    func setupCell(_ cell: UIView) // конфиг ячейки
}

final class LayersSquareConfigurator: LayersCollectionConfiguratorProtocol {
    var reuseId: String { String(describing: LayerCollectionViewCell.self) }
    var cellType: LayersCollectionCellType = .layerSquare
    var model: LayerViewModel?
    
    func setupCell(_ cell: UIView) {
        guard let cell = cell as? LayerCollectionViewCell,
              let sectionModel = model else { return }
        cell.configureCell(model: sectionModel)
    }
}

protocol LayersCollectionManagerDelegate: AnyObject {
    func didSelect(at index: Int)
}

protocol LayersCollectionManagerProtocol: AnyObject {
    func injectCollection(_ collectionView: UICollectionView)
    func injectDelegate(_ delegate: LayersCollectionManagerDelegate)
    func displaySquareEditors(_ results: [LayerViewModel])
}

final class LayersCollectionManager: NSObject, LayersCollectionManagerProtocol {
    // MARK: - Private properties
    private var collectionView: UICollectionView?
    private var configuratorsDataSource: [LayersCollectionConfiguratorProtocol] = []
    weak var delegate: LayersCollectionManagerDelegate?
    
    // MARK: - Public functions
    func injectCollection(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.collectionViewLayout = LayersCollectionViewLayout.createLayout()
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.allowsMultipleSelection = false
        self.collectionView?.register(LayerCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: LayerCollectionViewCell.self))
    }
    
    func injectDelegate(_ delegate: LayersCollectionManagerDelegate) {
        self.delegate = delegate
    }
    
    func displaySquareEditors(_ results: [LayerViewModel]) {
        var output: [LayersCollectionConfiguratorProtocol] = []
        
        results.forEach({ viewModel in
            output.append(layerListConfigurator(with: viewModel))
        })
        
        configuratorsDataSource = output.compactMap { $0 }
        collectionView?.reloadData()
    }
    
    // MARK: - Private functions
    
    private func layerListConfigurator(with model: LayerViewModel) -> LayersCollectionConfiguratorProtocol {
        let configurator = LayersSquareConfigurator()
        configurator.model = model
        return configurator
    }
}

extension LayersCollectionManager: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        configuratorsDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configurator = configuratorsDataSource[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.reuseId, for: indexPath)
        configurator.setupCell(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let configurator = configuratorsDataSource[indexPath.item]
        guard let cell = collectionView.cellForItem(at: indexPath) as? LayerCollectionViewCell else { return }
        cell.setSelected()
        delegate?.didSelect(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? LayerCollectionViewCell else { return }
        cell.setDeselected()
    }
}
