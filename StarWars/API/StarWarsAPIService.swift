//
//  StarWarsAPIService.swift
//  StarWars
//
//  Created by Usama Khan on 8/4/23.
//

import Foundation
import Alamofire

class StarWarsAPIService {
    
    func requestResult(url: String,
                       method: HTTPMethod,
                       params: Parameters,
                       additionalHeaders: [String: String] = [:],
                       completion: @escaping (Result<Data, Error>) -> Void) {
                  
        var headers: HTTPHeaders = [:]
        for (key, value) in additionalHeaders {
            headers.add(name: key, value: value)
        }

        AF.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(let result):
                    if let data = result {
                        completion(.success(data))
                    } else {
                        completion(.failure(StarWarsAPIError.invalidResponseError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
