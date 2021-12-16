//
//  Webservice.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class Webservice{
    
    func load<T>(resource: Resource<T>, completion: @escaping(Result<(T?),NetworkError>) -> ()){

        URLSession.shared.dataTask(with: resource.url) { data, response, error in

            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.serverError(statusCode: response.statusCode)))
                return
            }

            if let data = data {
                DispatchQueue.main.async {
                    completion(.success(resource.parse(data)))
                }
            } else {
                completion(.failure(.noData))
            }
        }.resume()
    }
}
