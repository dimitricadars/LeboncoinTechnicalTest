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
    
    func getCategories(completion: @escaping (Result<[CategoryViewModel],Error>) -> Void) {
        
        categoryService.getCategories { resultOfCat in
            switch resultOfCat {
                
            case .success:
                if let arrayCat = try? resultOfCat.get() {
                    self.categoryViewModels = arrayCat
                    completion(.success(arrayCat))
                }
                break
            case .failure(let error):
                completion(.failure(error))
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
        return ""
    }
    
}
