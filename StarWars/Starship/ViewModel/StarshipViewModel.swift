//
//  StarshipViewModel.swift
//  StarWars
//
//  Created by Usama Khan on 8/4/23.
//

import Combine
import Alamofire
import Foundation

class StarshipViewModel {
    
    var allStarships = [Starship]()
    var starshipResponse: StarshipsResponse?
    private var currentPage: Int = 1
    var totalStarships: Int = 0
    var isFetching: Bool = false
    private let starshipRepository: StarShipRepositoryProtocol
    internal var filteredStarships = [Starship]()
    private var manufacturersSet = Set<String>()
    var pathURL = APIPath.starship
    var availableManufacturers: [String] {
        return Array(manufacturersSet)
    }
    private var selectedManufacturerSubject = PassthroughSubject<String?, Never>()

    var filteredStarshipsPublisher: AnyPublisher<[Starship], Never> {
        return selectedManufacturerSubject
            .map { [weak self] manufacturer -> [Starship] in
                guard let self = self else { return [] }
                if let manufacturer = manufacturer {
                    return self.allStarships.filter { $0.manufacturer == manufacturer }
                } else {
                    return self.allStarships
                }
            }
            .eraseToAnyPublisher()
    }

    init(starshipRepository: StarShipRepositoryProtocol) {
        self.starshipRepository = starshipRepository
        fetchStarships()
    }

    internal func fetchStarships() {
        guard !isFetching else { return }
        isFetching = true
        starshipRepository.getStarships(pathURL: pathURL) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            switch result {
            case .success(let starshipResponse):
                let starships = starshipResponse.results
                self.totalStarships = starshipResponse.count
                self.starshipResponse = starshipResponse
                
                if self.currentPage == 1 {
                    self.allStarships = starships
                } else {
                    self.allStarships.append(contentsOf: starships)
                }
                self.selectedManufacturerSubject.send(nil)
                self.filteredStarships = self.allStarships
                
                self.manufacturersSet = Set(self.allStarships.map { $0.manufacturer })
            case .failure(let error):
                print("Error fetching starships: \(error)")
            }
        }
    }
    
    func fetchNextPage() {
        guard let nextPageURL = starshipResponse?.next, !isFetching else {
            return
        }
        
        pathURL = nextPageURL.absoluteString
        currentPage += 1
        fetchStarships()
    }
    func refreshStarships() {
        pathURL = APIPath.starship
        currentPage = 1
        fetchStarships()
    }

    func applyFilter(manufacturer: String?) {
        guard let manufacturer = manufacturer else {
            filteredStarships = allStarships
            return
        }
        
        filteredStarships = allStarships.filter { starship in
            starship.manufacturer == manufacturer
        }
        
    }
}
