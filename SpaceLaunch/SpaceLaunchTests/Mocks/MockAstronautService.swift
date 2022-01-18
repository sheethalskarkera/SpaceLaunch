//
//  MockAstronautService.swift
//  SpaceLaunchTests
//
//  Created by Sheethal Karkera on 19/1/22.
//

import Foundation
@testable import SpaceLaunch

class MockAstronautService: AstronautService {
    
    var isSuccess = true
    
    override func getAstronautList(completion: @escaping ([Astronaut]?, Error?) -> Void) {
        let mockResponse = isSuccess ? "mock-astronaut-list" : "mock-astronaut-error"
        do {
            let response = try JSONDecoder().decode(AstronautsResponse.self, from: MockResponseService().fetchData(from: mockResponse))
            completion(response.astronauts, nil)
        }
        catch let error {
            completion(nil, error)
        }
    }
    
    override func getAstronautDetails(for id: Int, completion: @escaping (Astronaut?, Error?) -> Void) {
        let mockResponse = isSuccess ? "mock-astronaut-detail" : "mock-astronaut-detail-error"
        do {
            let response = try JSONDecoder().decode(Astronaut.self, from: MockResponseService().fetchData(from: mockResponse))
            completion(response, nil)
        }
        catch let error {
            completion(nil, error)
        }        
    }
}
