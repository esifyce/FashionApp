//
//  Clothes.swift
//  FashionApp
//
//  Created by Andrey on 6.09.23.
//

import UIKit

enum Clothes: Int, CustomStringConvertible {
    case hair = 0
    case pants
    case shoes
    case dress
    
    var getClothes: [String] {
        switch self {
        case .shoes:
            return ["shoes1", "shoes2", "shoes3", "shoes4"]
        case .hair:
            return ["hair1", "hair2", "hair3", "hair4", "hair5"]
        case .pants:
            return ["pants1", "pants2", "pants3", "pants4"]
        case .dress:
            return ["dress1", "dress2", "dress3", "dress4"]
        }
    }
    
    var previewClothes: [String] {
        switch self {
        case .shoes:
            return ["previewShoes1", "previewShoes2", "previewShoes3", "previewShoes4"]
        case .hair:
            return ["hair1", "hair2", "hair3", "hair4", "hair5"]
        case .pants:
            return ["pants1", "pants2", "pants3", "pants4"]
        case .dress:
            return ["dress1", "dress2", "dress3", "dress4"]
        }
    }
    
    var description: String {
        switch self {
        case .shoes:
            return "Shoes"
        case .hair:
            return "Hair"
        case .pants:
            return "Pants"
        case .dress:
            return "Dress"
        }
    }
}
