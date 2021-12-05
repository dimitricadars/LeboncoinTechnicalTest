//
//  ClassifiedAdViewModel.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation

class ClassifiedAdViewModel {
    
    let classifiedAd: ClassifiedAdModel
    
    let categoryID: Int
    let title, description: String
    let price: Int
    let imageSmall: String
    let imageThumb: String
    let creationDate: Date?
    let isUrgent: Bool
    
    
    init(classifiedAd: ClassifiedAdModel) {
        self.classifiedAd = classifiedAd
        categoryID = classifiedAd.categoryID
        title = classifiedAd.title
        description = classifiedAd.description
        price = classifiedAd.price
        imageSmall = classifiedAd.imagesURL.small ?? ""
        imageThumb = classifiedAd.imagesURL.thumb ?? ""
        creationDate = classifiedAd.creationDate.toDate()
        isUrgent = classifiedAd.isUrgent
    }
}
