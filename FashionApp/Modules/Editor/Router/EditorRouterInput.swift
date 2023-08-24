//
//  EditorRouterInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

protocol EditorRouterInput: AnyObject {
    func popViewController()
    func shareSkinImage(with image: UIImage?)
}
