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
    
    func load<T>(resource: Resource<T>, completion: @escaping(Result<(T?),Error>) -> ()){

        URLSession.shared.dataTask(with: resource.url) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                DispatchQueue.main.async {
                    completion(.success(resource.parse(data)))
                }
            }
        }.resume()
    }
}
