//
//  LayersCollectionViewLayout.swift
//  FashionApp
//
//  Created by Krasivo on 21.08.2023.
//

import Foundation

final class LayersCollectionViewLayout: UICollectionViewLayout{
    static func createLayout() -> UICollectionViewLayout {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(isIpad ? 240 : 160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: isIpad ? 24 : 10, bottom: 0, trailing: isIpad ? 24 : 10)
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
