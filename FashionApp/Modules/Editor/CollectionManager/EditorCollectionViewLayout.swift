//
//  EditorCollectionViewLayout.swift
//  FashionApp
//
//  Created by Krasivo on 08.08.2023.
//

import UIKit

class EditorCollectionViewLayout: UICollectionViewLayout{
    static func createLayout() -> UICollectionViewLayout {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(CGFloat(isIpad ? 100 : 72)),
                                               heightDimension: .absolute(CGFloat(isIpad ? 100 : 72)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 16
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
