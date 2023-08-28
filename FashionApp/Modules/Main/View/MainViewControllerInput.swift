//
//  MainViewControllerInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation
import KMDrawViewSDK

protocol MainViewControllerInput: AnyObject {
    func getCanvas() -> KMDrawView
}
