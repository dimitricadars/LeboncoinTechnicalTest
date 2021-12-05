//
//  ClassifiedAdModel.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation

struct ClassifiedAdModel: Decodable {
    var id, categoryID: Int
    var title, description: String
    var price: Int
    var imagesURL: ImagesURL
    var creationDate: String
    var isUrgent: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case description = "description"
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
    }
}

struct ImagesURL: Decodable {
    var small, thumb: String?
}
