//
//  Constants.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation

struct Constants {
    
    struct Urls {
        
        static func urlForClassifiedAds() -> URL {
            return URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!
        }
        
        static func urlForCategories() -> URL {
            return URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!
        }
    }
    
}
