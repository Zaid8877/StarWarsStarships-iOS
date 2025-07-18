//
//  StarshipViewModelTests.swift
//  StarWarsTests
//
//  Created by Usama Khan on 8/4/23.
//

import Foundation
import XCTest
@testable import StarWars

final class StarshipViewModelTests: XCTestCase {
    
    var viewModel: StarshipViewModel!
    var mockRepository: MockStarShipRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockStarShipRepository()
        viewModel = StarshipViewModel(starshipRepository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testFetchStarships() {
        viewModel.fetchStarships()

        let expectation = XCTestExpectation(description: "Starships fetched")
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)

        XCTAssertFalse(viewModel.isFetching)

        
        XCTAssertEqual(viewModel.allStarships.count, 3)
        XCTAssertEqual(viewModel.filteredStarships.count, 3)
    }
    
    func testFetchNextPage() {
        viewModel.fetchStarships()
        viewModel.fetchNextPage()
        
    }
    
    
    func testApplyFilter() {
        viewModel.fetchStarships()
        
        XCTAssertEqual(viewModel.allStarships.count, 3)
        
        viewModel.applyFilter(manufacturer: "Manufacturer 1")
        XCTAssertEqual(viewModel.filteredStarships.count, 1)
        
        viewModel.applyFilter(manufacturer: "Manufacturer 2")
        XCTAssertEqual(viewModel.filteredStarships.count, 2)
        
        viewModel.applyFilter(manufacturer: "")
        XCTAssertEqual(viewModel.filteredStarships.count, 0)
        
        viewModel.applyFilter(manufacturer: nil)
        XCTAssertEqual(viewModel.filteredStarships.count, 3) 
    }
    
}
