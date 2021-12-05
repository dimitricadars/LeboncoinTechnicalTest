//
//  ClassifiedAdsViewModel.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation

class ClassifiedAdsViewModel {
    
    private var classifiedAdService : ClassifiedAdServiceProtocol
    var classifiedAdViewModels = [ClassifiedAdViewModel]()
    
    init(classifiedAdService: ClassifiedAdServiceProtocol = ClassifiedAdService()) {
        self.classifiedAdService = classifiedAdService
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return classifiedAdViewModels.count
    }
    
    func getClassifiedAds(completion: @escaping ([ClassifiedAdViewModel]) -> Void) {
        
        classifiedAdService.getClassifiedAds { resultOfClassifiedAd in
            switch resultOfClassifiedAd {
                
            case .success(_):
                if let arrayClassifiedAd = try? resultOfClassifiedAd.get() {
                    self.classifiedAdViewModels = arrayClassifiedAd
                    completion(arrayClassifiedAd)
                }
                break
            case .failure(_):
                completion([])
                break
            }
            
        }
    }
    
    func sortClassifiedAdsByDateAndUrgency(arrayClassifiedAd :[ClassifiedAdViewModel]) ->[ClassifiedAdViewModel]{
        let sortedItemsByDate = arrayClassifiedAd.sorted(by: {($0.creationDate!) > ($1.creationDate!)})
        let sortedItemsByUrgency = sortedItemsByDate.sorted(by: {$0.isUrgent == true && $1.isUrgent != true})
        return sortedItemsByUrgency
    }
    
    func filterClassifiedAdsByCategoryID(catID :Int)->[ClassifiedAdViewModel]{
        if catID == 0{
            return self.classifiedAdViewModels
        }else{
            let arrayToFilter = self.classifiedAdViewModels.filter{$0.categoryID == catID}
            return arrayToFilter
        }
    }
    
}
