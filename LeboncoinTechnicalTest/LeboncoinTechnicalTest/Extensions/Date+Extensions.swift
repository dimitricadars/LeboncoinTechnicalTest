//
//  Date+Extensions.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation

extension Date{
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR_POSIX")
        dateFormatter.dateFormat = "EEEE d MMMM yyyy à HH:mm"
        let str = dateFormatter.string(from: self)
        return str
    }
}
