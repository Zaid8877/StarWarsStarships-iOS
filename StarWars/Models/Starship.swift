//
//  Starship.swift
//  StarWars
//
//  Created by Usama Khan on 8/4/23.
//
import Foundation

struct Starship: Codable, Hashable {
    let name: String
    let model: String
    let starshipClass: String?
    let manufacturer: String
    let costInCredits: String?
    let length: String?
    let crew: String?
    let passengers: String?
    let maxAtmospheringSpeed: String?
    let hyperdriveRating: String?
    let MGLT: String?
    let cargoCapacity: String?
    let consumables: String?
    let films: [URL]?
    
    var identifier: String {
        return "\(name)_\(model)"
    }
    
    static func ==(lhs: Starship, rhs: Starship) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

struct StarshipsResponse: Codable, Hashable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [Starship]
}
