//
//  CategoriesViewModel.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation

class CategoriesViewModel {
    
    private var categoryService : CategoryServiceProtocol
    var categoryViewModels = [CategoryViewModel]()
    
    init(categoryService: CategoryServiceProtocol = CategoryService()) {
        self.categoryService = categoryService
    }
    
    func getCategories(completion: @escaping ([CategoryViewModel]) -> Void) {
        
        categoryService.getCategories { resultOfCat in
            switch resultOfCat {
                
            case .success(_):
                if let arrayCat = try? resultOfCat.get() {
                    self.categoryViewModels = arrayCat
                    completion(arrayCat)
                }
                break
            case .failure(_):
                completion([])
                break
            }
        }
    }
    
    func getCategoryName(by CatId: Int) -> String {
        
        for categoryVM in self.categoryViewModels {
            if CatId == categoryVM.id {
                return categoryVM.name
            }
        }
        return "Non défini"
    }
    
}
