//
//  EditorCollectionManager.swift
//  FashionApp
//
//  Created by Krasivo on 08.08.2023.
//

import UIKit

enum EditorCollectionCellType {
    case editorSquare
}

protocol EditorCollectionConfiguratorProtocol {
    var reuseId: String { get } // переменная для ячейки с reuse id
    var cellType: EditorCollectionCellType { get } // тип ячейки для отработки нажатия
    var model: EditorViewModel? { get set } // моделька
    func setupCell(_ cell: UIView) // конфиг ячейки
}

final class EditorSquareConfigurator: EditorCollectionConfiguratorProtocol {
    var reuseId: String { String(describing: EditorCollectionViewCell.self) }
    var cellType: EditorCollectionCellType = .editorSquare
    var model: EditorViewModel?
    
    func setupCell(_ cell: UIView) {
        guard let cell = cell as? EditorCollectionViewCell,
              let sectionModel = model else { return }
        cell.configureCell(model: sectionModel)
    }
}

protocol EditorCollectionManagerDelegate: AnyObject {
    func addedItemToManiquen(viewModel: EditorViewModel)
}

protocol EditorCollectionManagerProtocol: AnyObject {
    func injectCollection(_ collectionView: UICollectionView)
    func injectDelegate(_ delegate: EditorCollectionManagerDelegate)
    func displaySquareEditors(_ results: [EditorViewModel])
}

final class EditorCollectionManager: NSObject, EditorCollectionManagerProtocol {
    // MARK: - Private properties
    private var collectionView: UICollectionView?
    private var configuratorsDataSource: [EditorCollectionConfiguratorProtocol] = []
    weak var delegate: EditorCollectionManagerDelegate?
    
    // MARK: - Public functions
    func injectCollection(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.collectionViewLayout = EditorCollectionViewLayout.createLayout()
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(EditorCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: EditorCollectionViewCell.self))
    }
    
    func injectDelegate(_ delegate: EditorCollectionManagerDelegate) {
        self.delegate = delegate
    }
    
    func displaySquareEditors(_ results: [EditorViewModel]) {
        var output: [EditorCollectionConfiguratorProtocol] = []
        
        results.forEach({ viewModel in
            output.append(editorsListConfigurator(with: viewModel))
        })
        
        configuratorsDataSource = output.compactMap { $0 }
        collectionView?.reloadData()
    }
    
    // MARK: - Private functions
    
    private func editorsListConfigurator(with model: EditorViewModel) -> EditorCollectionConfiguratorProtocol {
        let configurator = EditorSquareConfigurator()
        configurator.model = model
        return configurator
    }
}

extension EditorCollectionManager: UICollectionViewDelegate, UICollectionViewDataSource {
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
        case .editorSquare:
            guard let currentModel = configurator.model else { return }
            delegate?.addedItemToManiquen(viewModel: currentModel)
            configuratorsDataSource = configuratorsDataSource.map { configurator in
                var mutableConfigurator = configurator
                mutableConfigurator.model?.isSelectedImage = false
                return mutableConfigurator
            }
            configuratorsDataSource[indexPath.row].model?.isSelectedImage = true
            collectionView.reloadData()
        }
    }
}
