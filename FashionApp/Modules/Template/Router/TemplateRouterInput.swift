//
//  TemplateRouterInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation
import KMDrawViewSDK

protocol TemplateRouterInput: AnyObject {
    func openMore()
    func popViewController()
    func goToEditor(kmDrawView: KMDrawView)
}
