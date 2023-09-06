//
//  TemplateInteractorInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation

protocol TemplateInteractorInput: AnyObject {
    func getViewModel(completion: @escaping ([MainViewModel]) -> Void) 
}
