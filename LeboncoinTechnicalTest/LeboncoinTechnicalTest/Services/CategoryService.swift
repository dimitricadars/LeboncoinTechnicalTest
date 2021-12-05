//
//  CategoryService.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation

protocol CategoryServiceProtocol {
    func getCategories(completion: @escaping(Result<[CategoryViewModel],Error>) -> ())
}

final class CategoryService : CategoryServiceProtocol{
    
    func getCategories(completion: @escaping(Result<[CategoryViewModel],Error>) -> ()) {
        let categoriesURL = Constants.Urls.urlForCategories()
        let categoriesResource = Resource<[CategoryModel]>(url: categoriesURL) { data in
            let categoryModel = try? JSONDecoder().decode([CategoryModel].self, from: data)
            return categoryModel
        }
        
        Webservice().load(resource: categoriesResource) { (resultOfCat) in
            switch resultOfCat {
                
            case .success:
                if let arrayCat = try? resultOfCat.get() {
                    let categoryViewModels = arrayCat.map {CategoryViewModel(category: $0)}
                    completion(.success(categoryViewModels))
                }
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
}
