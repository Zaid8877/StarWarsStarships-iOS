//
//  StarShipRepository.swift
//  StarWars
//
//  Created by Usama Khan on 8/4/23.
//

import Foundation
import Alamofire
protocol StarShipRepositoryProtocol {
    func getStarships(pathURL: String, completion: @escaping (Result<StarshipsResponse, StarWarsAPIError>) -> Void)
}
final class StarShipRepository: StarShipRepositoryProtocol {
    
    let authEndPoint = StarWarsAPIService()
    
    let decoder: JSONDecoder = {
        let decoder =  JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    func getStarships(pathURL: String,completion: @escaping (Result<StarshipsResponse, StarWarsAPIError>) -> Void) {

        authEndPoint.requestResult(url: pathURL, method: .get, params: [:], completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    let starships = try self.decoder.decode(StarshipsResponse.self, from: data)
                    completion(.success(starships))
                } catch {
                    completion(.failure(StarWarsAPIError.decodingFailed))
                    return
                }
                
            case .failure(_):
                completion(.failure(.invalidResponseError))
            }
        })
    }
}
