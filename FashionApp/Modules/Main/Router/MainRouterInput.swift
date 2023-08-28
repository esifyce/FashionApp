//
//  MainRouterInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation
import KMDrawViewSDK

protocol MainRouterInput: AnyObject {
    func openMore(with name: String,
                  rename: @escaping (String?) -> (),
                  shareTo: @escaping () -> (),
                  delete: @escaping () -> ())
    func goToAddTemplate(kmDrawView: KMDrawView)
    func goToPaywall()
    func settingTapped() 
}
