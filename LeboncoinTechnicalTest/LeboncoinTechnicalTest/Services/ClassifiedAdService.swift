//
//  ClassifiedAdService.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation

protocol ClassifiedAdServiceProtocol {
    func getClassifiedAds(completion: @escaping(Result<[ClassifiedAdViewModel],Error>) -> ())
}

final class ClassifiedAdService : ClassifiedAdServiceProtocol {
    
    func getClassifiedAds(completion: @escaping (Result<[ClassifiedAdViewModel],Error>) -> ()) {
        
        let classifiedAdsURL = Constants.Urls.urlForClassifiedAds()
        let classifiedAdsResource = Resource<[ClassifiedAdModel]>(url: classifiedAdsURL) { data in
            let classifiedAdsModel = try? JSONDecoder().decode([ClassifiedAdModel].self, from: data)
            return classifiedAdsModel
        }
        
        Webservice().load(resource: classifiedAdsResource) { (resultOfClassifiedAd) in
            switch resultOfClassifiedAd {
                
            case .success:
                if let arrayClassifiedAd = try? resultOfClassifiedAd.get() {
                    let classifiedAdViewModels = arrayClassifiedAd.map {ClassifiedAdViewModel(classifiedAd: $0)}
                    completion(.success(classifiedAdViewModels))
                }
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
}
