//
//  TemplateViewControllerInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation
import KMDrawViewSDK

protocol TemplateViewControllerInput: AnyObject {
    func getCanvas() -> KMDrawView
}
