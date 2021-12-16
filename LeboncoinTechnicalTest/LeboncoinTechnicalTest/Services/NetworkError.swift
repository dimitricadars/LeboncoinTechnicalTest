//
//  NetworkError.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 15/12/2021.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}
