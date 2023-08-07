//
//  IphoneCollectionViewLayout.swift
//  FashionApp
//
//  Created by Andrey on 7.08.23.
//

import UIKit

class IphoneCollectionViewLayout: UICollectionViewLayout{
    static func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                 heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(8), top: .fixed(0), trailing: .fixed(8), bottom: .fixed(0))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(CGFloat(250).autoIphoneHeightSize))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                             subitems: [item, item])
          
            let section = NSCollectionLayoutSection(group: group)

            section.interGroupSpacing = 8
           

            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
    }
}
