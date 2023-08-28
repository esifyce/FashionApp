//
//  BrushViewModel.swift
//  FashionApp
//
//  Created by Krasivo on 22.08.2023.
//

import UIKit

struct BrushViewModel: Equatable {
    let image: UIImage
    var isSelected: Bool
    let opacity: Int
    let size: Int
    let type: BrushType
    let color: UIColor
    let texture: String
    
    init(image: UIImage, isSelected: Bool, opacity: Int, size: Int, type: BrushType, color: UIColor, texture: String = "") {
        self.image = image
        self.isSelected = isSelected
        self.opacity = opacity
        self.size = size
        self.type = type
        self.color = color
        self.texture = texture
    }
}

enum BrushType: String {
    case pen, pencil, erasse, marker, flomaster, texture
}

enum CustomBrushType {
    case point, line, circle
}
