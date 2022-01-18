//
//  SpaceLaunchListViewModelTests.swift
//  SpaceLaunchTests
//
//  Created by Sheethal Karkera on 19/1/22.
//

import XCTest
@testable import SpaceLaunch

class SpaceLaunchListViewModelTests: XCTestCase, SpaceLaunchListViewModelDelegate {
    
    var expectation: XCTestExpectation?
    var viewModel = SpaceLaunchListViewModel(astronautService: MockAstronautService())
    
    override func setUp() {
        viewModel.delegate = self
    }
    
    func testViewModelSuccess() {
        viewModel.getAstronautList()
        expectation = expectation(description: "ViewModelSuccess")
        waitForExpectations(timeout: 5)
        XCTAssertEqual(viewModel.numberOfRows, 2)
        XCTAssertEqual(viewModel.title, "Space Launch Astronauts")
        XCTAssertTrue(viewModel.astronauts != nil)
        XCTAssertEqual(viewModel.astronauts?.first?.name, "Franz Viehböck")
        XCTAssertEqual(viewModel.astronauts?.first?.nationality, "Austrian")
        XCTAssertEqual(viewModel.astronauts?.first?.dateOfBirth?.ISO8601Format(), "1960-08-23T14:00:00Z")
        XCTAssertEqual(viewModel.astronauts?.first?.firstFlight?.ISO8601Format(), "1991-10-02T05:59:38Z")
        XCTAssertEqual(viewModel.astronauts?.first?.id, 276)
        XCTAssertEqual(viewModel.astronauts?.first?.bio, "Franz Artur Viehböck (born August 24, 1960 in Vienna) is an Austrian electrical engineer, and was Austria\'s first cosmonaut. He was titulated „Austronaut“ by his country\'s media. He visited the Mir space station in 1991 aboard Soyuz TM-13, returning aboard Soyuz TM-12 after spending just over a week in space.")
        XCTAssertEqual(viewModel.astronauts?.first?.status?.name, "Retired")
    }
    
    func testViewModelSort() {
        viewModel.getAstronautList()
        expectation = expectation(description: "Sort")
        waitForExpectations(timeout: 5)
        viewModel.sortAstronauts(type: .descending)
        XCTAssertEqual(viewModel.numberOfRows, 2)
        XCTAssertEqual(viewModel.title, "Space Launch Astronauts")
        XCTAssertEqual(viewModel.astronauts?.first?.name, "Marcos Pontes")
        XCTAssertEqual(viewModel.astronauts?.first?.nationality, "Brazilian")
        XCTAssertEqual(viewModel.astronauts?.first?.dateOfBirth?.ISO8601Format(), "1963-03-10T14:00:00Z")
        XCTAssertEqual(viewModel.astronauts?.first?.firstFlight?.ISO8601Format(), "2006-03-30T02:30:00Z")
        XCTAssertEqual(viewModel.astronauts?.first?.id, 225)
        XCTAssertEqual(viewModel.astronauts?.first?.bio, "Marcos Cesar Pontes (born March 11, 1963) is a Brazilian Air Force pilot, engineer, AEB astronaut and author. He became the first South American and the first Lusophone to go into space when he launched into the International Space Station aboard Soyuz TMA-8 on March 30, 2006. He is the only Brazilian to have completed the NASA astronaut training program, although he switched to training in Russia after NASA\'s Space Shuttle program encountered problems.")
        XCTAssertEqual(viewModel.astronauts?.first?.status?.name, "Active")
    }
    
    func testViewModelErrorResponse() {
        let mockService = MockAstronautService()
        mockService.isSuccess = false
        let spaceLaunchListViewModel = SpaceLaunchListViewModel(astronautService: mockService)
        spaceLaunchListViewModel.delegate = self
        spaceLaunchListViewModel.getAstronautList()
        expectation = expectation(description: "Error")
        waitForExpectations(timeout: 5)
        XCTAssertEqual(spaceLaunchListViewModel.numberOfRows, 0)
        XCTAssertTrue(spaceLaunchListViewModel.astronauts == nil)
    }
    
    func shouldReloadView() {
        expectation?.fulfill()
        expectation = nil
    }
    
    func showErrorMessage(message: String?) {
        expectation?.fulfill()
        expectation = nil
    }
    
    
    
}
