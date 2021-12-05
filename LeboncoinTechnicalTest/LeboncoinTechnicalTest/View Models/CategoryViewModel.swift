//
//  CategoryViewModel.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation

class CategoryViewModel {
    
    let id: Int
    let name: String
    
    init(category: CategoryModel) {
        id = category.id
        name = category.name
    }
    
}
