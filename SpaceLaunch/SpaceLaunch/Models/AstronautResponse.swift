//
//  AstronautResponse.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 19/1/22.
//

import Foundation

struct AstronautsResponse: Codable {
    var count: Int = 0
    var next: String?
    var previous: String?
    var astronauts: [Astronaut] = []
    
    enum CodingKeys: String, CodingKey {
        case count
        case astronauts = "results"
        case next
        case previous
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.astronauts = try container.decode([Astronaut].self, forKey: .astronauts)
        self.next = try container.decode(String?.self, forKey: .next)
        self.previous = try container.decode(String?.self, forKey: .previous)
    }
}
