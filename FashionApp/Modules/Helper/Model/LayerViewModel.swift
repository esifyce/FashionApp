//
//  LayerViewModel.swift
//  FashionApp
//
//  Created by Krasivo on 21.08.2023.
//

import Foundation

struct LayerViewModel {
    var name: String
    var color: UIColor
    var actions: [LayerAction]
    var opacity: Int
    
    init() {
        name = ""
        color = .red
        actions = []
        opacity = 100
    }
    
    init(name: String,
         color: UIColor,
         actions: [LayerAction],
         opacity: Int) {
        self.name = name
        self.color = color
        self.actions = actions
        self.opacity = opacity
    }
}
