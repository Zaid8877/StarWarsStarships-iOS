//
//  MockStarShipRepository.swift
//  StarWarsTests
//
//  Created by Usama Khan on 8/4/23.
//

import Foundation
@testable import StarWars

class MockStarShipRepository: StarShipRepositoryProtocol {
    func getStarships(pathURL: String, completion: @escaping (Result<StarWars.StarshipsResponse, StarWars.StarWarsAPIError>) -> Void) {
        let starship1 = Starship(name: "Starship 1", model: "Model 1", starshipClass: nil, manufacturer: "Manufacturer 1", costInCredits: nil, length: nil, crew: nil, passengers: nil, maxAtmospheringSpeed: nil, hyperdriveRating: nil, MGLT: nil, cargoCapacity: nil, consumables: nil, films: nil)
        let starship2 = Starship(name: "Starship 2", model: "Model 2", starshipClass: nil, manufacturer: "Manufacturer 2", costInCredits: nil, length: nil, crew: nil, passengers: nil, maxAtmospheringSpeed: nil, hyperdriveRating: nil, MGLT: nil, cargoCapacity: nil, consumables: nil, films: nil)
        let starship3 = Starship(name: "Starship 3", model: "Model 3", starshipClass: nil, manufacturer: "Manufacturer 2", costInCredits: nil, length: nil, crew: nil, passengers: nil, maxAtmospheringSpeed: nil, hyperdriveRating: nil, MGLT: nil, cargoCapacity: nil, consumables: nil, films: nil)

        
        let starships = [starship1, starship2, starship3]
        let starshipResponse = StarshipsResponse(count: starships.count, next: nil, previous: nil, results: starships)
        
        completion(.success(starshipResponse))
    }
}
