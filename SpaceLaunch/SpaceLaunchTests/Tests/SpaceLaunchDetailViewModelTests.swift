//
//  SpaceLaunchDetailViewModelTests.swift
//  SpaceLaunchTests
//
//  Created by Sheethal Karkera on 19/1/22.
//


import XCTest
@testable import SpaceLaunch

class SpaceLaunchDetailViewModelTests: XCTestCase, SpaceLaunchDetailViewModelDelegate {
    
    var expectation: XCTestExpectation?
    var viewModel = SpaceLaunchDetailViewModel(astronautService: MockAstronautService(), id: 276)
    
    override func setUp() {
        viewModel.delegate = self
    }
    
    func testViewModelSuccess() {
        viewModel.getAstronautDetails()
        expectation = expectation(description: "ViewModelSuccess")
        waitForExpectations(timeout: 5)
        XCTAssertEqual(viewModel.nameText, "Name: Franz Viehböck")
        XCTAssertEqual(viewModel.nationality, "Nationality: Austrian")
        XCTAssertEqual(viewModel.firstFlight, "First Flight: October 2, 1991")
        XCTAssertEqual(viewModel.id, 276)
        XCTAssertEqual(viewModel.dateOfBirth, "DOB: August 24, 1960")
        XCTAssertTrue(viewModel.astronaut != nil)
        XCTAssertEqual(viewModel.astronaut?.bio, "Franz Artur Viehböck (born August 24, 1960 in Vienna) is an Austrian electrical engineer, and was Austria\'s first cosmonaut. He was titulated „Austronaut“ by his country\'s media. He visited the Mir space station in 1991 aboard Soyuz TM-13, returning aboard Soyuz TM-12 after spending just over a week in space.")
    }
    
    func testViewModelErrorResponse() {
        let mockService = MockAstronautService()
        mockService.isSuccess = false
        let spaceLaunchDetailViewModel = SpaceLaunchDetailViewModel(astronautService: mockService, id: 677)
        spaceLaunchDetailViewModel.delegate = self
        spaceLaunchDetailViewModel.getAstronautDetails()
        expectation = expectation(description: "Error")
        waitForExpectations(timeout: 5)
        XCTAssertTrue(spaceLaunchDetailViewModel.astronaut == nil)
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
