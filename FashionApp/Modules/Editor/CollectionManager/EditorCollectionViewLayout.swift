//
//  EditorCollectionViewLayout.swift
//  FashionApp
//
//  Created by Krasivo on 08.08.2023.
//

import UIKit

class EditorCollectionViewLayout: UICollectionViewLayout{
    static func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(CGFloat(72).autoIphoneHeightSize),
                                                 heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(CGFloat(72).autoIphoneHeightSize))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
          //  group.interItemSpacing = .fixed(8)

            let section = NSCollectionLayoutSection(group: group)

            section.interGroupSpacing = 16
//            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)


            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
    }
}
