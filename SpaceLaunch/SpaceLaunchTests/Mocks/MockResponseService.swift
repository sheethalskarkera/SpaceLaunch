//
//  MockResponseService.swift
//  SpaceLaunchTests
//
//  Created by Sheethal Karkera on 19/1/22.
//

import Foundation

class MockResponseService {
  
  func fetchData(from fileName: String) -> Data {
    // Read JSON file
    let testBundle = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") ?? ""
    let data = FileManager.default.contents(atPath: testBundle)!
    return data
  }
  
}
