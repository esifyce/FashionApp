//
//  Collection+Extension.swift
//  FashionApp
//
//  Created by Andrey on 22.08.23.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
