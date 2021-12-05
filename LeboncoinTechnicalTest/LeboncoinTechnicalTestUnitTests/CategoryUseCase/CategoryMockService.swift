//
//  CategoryMockService.swift
//  LeboncoinTechnicalTestUnitTests
//
//  Created by Dimitri CADARS on 05/12/2021.
//

@testable import LeboncoinTechnicalTest

final class CategoryMockService: CategoryServiceProtocol {
    
    var categoryResult : Result<[CategoryViewModel], Error> =
        .success([CategoryViewModel(category: CategoryModel(id: 1, name: "Véhicule")),
                  CategoryViewModel(category: CategoryModel(id: 2, name: "Mode")),
                  CategoryViewModel(category: CategoryModel(id: 3, name: "Bricolage")),
                  CategoryViewModel(category: CategoryModel(id: 4, name: "Maison")),
                  CategoryViewModel(category: CategoryModel(id: 5, name: "Loisirs")),
                  CategoryViewModel(category: CategoryModel(id: 6, name: "Immobilier")),
                  CategoryViewModel(category: CategoryModel(id: 7, name: "Livres/CD/DVD")),
                  CategoryViewModel(category: CategoryModel(id: 8, name: "Multimédia")),
                  CategoryViewModel(category: CategoryModel(id: 9, name: "Service")),
                  CategoryViewModel(category: CategoryModel(id: 10, name: "Animaux"))])
    
    func getCategories(completion: @escaping (Result<[CategoryViewModel], Error>) -> ()) {
        completion(categoryResult)
    }
    
}
