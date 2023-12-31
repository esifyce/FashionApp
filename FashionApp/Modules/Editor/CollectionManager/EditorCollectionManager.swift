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
    func setupCell(_ cell: UIView) // конфиг ячейки
}

final class EditorSquareConfigurator: EditorCollectionConfiguratorProtocol {
    var reuseId: String { String(describing: EditorCollectionViewCell.self) }
    var cellType: EditorCollectionCellType = .editorSquare

    func setupCell(_ cell: UIView) {}
}

protocol EditorCollectionManagerDelegate: AnyObject {}

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
            break
        }
    }
}
