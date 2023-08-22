//
//  BrushCollectionManager.swift
//  FashionApp
//
//  Created by Krasivo on 22.08.2023.
//

import UIKit

enum BrushCollectionCellType {
    case pen
}

protocol BrushCollectionConfiguratorProtocol {
    var reuseId: String { get } // переменная для ячейки с reuse id
    var cellType: BrushCollectionCellType { get } // тип ячейки для отработки нажатия
    var model: BrushViewModel? { get set } // моделька
    func setupCell(_ cell: UIView) // конфиг ячейки
}

final class BrushSquareConfigurator: BrushCollectionConfiguratorProtocol {
    var reuseId: String { String(describing: BrushCollectionViewCell.self) }
    var cellType: BrushCollectionCellType = .pen
    var model: BrushViewModel?
    
    func setupCell(_ cell: UIView) {
        guard let cell = cell as? BrushCollectionViewCell,
              let sectionModel = model else { return }
        cell.configureCell(viewModel: sectionModel)
    }
}

protocol BrushCollectionManagerDelegate: AnyObject {}

protocol BrushCollectionManagerProtocol: AnyObject {
    func injectCollection(_ collectionView: UICollectionView)
    func injectDelegate(_ delegate: BrushCollectionManagerDelegate)
    func displaySquareEditors(_ results: [BrushViewModel])
}

final class BrushCollectionManager: NSObject, BrushCollectionManagerProtocol {
    // MARK: - Private properties
    private var collectionView: UICollectionView?
    private var configuratorsDataSource: [BrushCollectionConfiguratorProtocol] = []
    weak var delegate: BrushCollectionManagerDelegate?
    
    // MARK: - Public functions
    func injectCollection(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.collectionViewLayout = BrushCollectionViewLayout.createLayout()
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(BrushCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: BrushCollectionViewCell.self))
    }
    
    func injectDelegate(_ delegate: BrushCollectionManagerDelegate) {
        self.delegate = delegate
    }
    
    func displaySquareEditors(_ results: [BrushViewModel]) {
        var output: [BrushCollectionConfiguratorProtocol] = []
        
        results.forEach({ viewModel in
            output.append(brushListConfigurator(with: viewModel))
        })
        
        configuratorsDataSource = output.compactMap { $0 }
        collectionView?.reloadData()
    }
    
    // MARK: - Private functions
    
    private func brushListConfigurator(with model: BrushViewModel) -> BrushCollectionConfiguratorProtocol {
        let configurator = BrushSquareConfigurator()
        configurator.model = model
        return configurator
    }
}

extension BrushCollectionManager: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        configuratorsDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configurator = configuratorsDataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.reuseId, for: indexPath)
        configurator.setupCell(cell)
        return cell
    }
}
