//
//  String+Extensions.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation

extension String {

    func toDate()-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR_POSIX")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let date = dateFormatter.date(from: self)
        return date
    }
}
