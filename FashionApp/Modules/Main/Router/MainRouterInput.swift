//
//  MainRouterInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation

protocol MainRouterInput: AnyObject {
    func openMore()
    func goToAddTemplate()
    func goToPaywall()
    func settingTapped() 
}
