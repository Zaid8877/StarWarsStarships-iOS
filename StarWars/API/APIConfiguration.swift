//
//  APIConfiguration.swift
//  StarWars
//
//  Created by Usama Khan on 8/4/23.
//

import Foundation

struct Constants {
    public static let baseEndPoint = "https://swapi.dev"
}

struct APIPath {
    public static let starship = Constants.baseEndPoint + "/api/starships/"
}

enum StarWarsAPIError: Error {
    case decodingFailed
    case invalidResponseError
}
