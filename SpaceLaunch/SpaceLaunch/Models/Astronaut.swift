//
//  Astronaut.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 19/1/22.
//


import Foundation

struct Astronaut: Codable {
    let id: Int
    let url: String?
    let name: String?
    let status: AstronautStatus?
    let type: AstronautType?
    let dateOfBirth: Date?
    let dateOfDeath: Date?
    let nationality: String?
    let bio: String?
    let profileImage: String?
    let profileImageThumbnail: String?
    let firstFlight: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case status
        case type
        case dateOfBirth = "date_of_birth"
        case dateOfDeath = "date_of_death"
        case nationality
        case bio
        case profileImage = "profile_image"
        case profileImageThumbnail = "profile_image_thumbnail"
        case firstFlight = "first_flight"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.url = try container.decode(String?.self, forKey: .url)
        self.name = try container.decode(String?.self, forKey: .name)
        self.status = try container.decode(AstronautStatus?.self, forKey: .status)
        self.type = try container.decode(AstronautType?.self, forKey: .type)
        let yyyyMMddDateFormatter = DateFormatter.yyyyMMdd
        let dateOfBirthString = try container.decode(String?.self, forKey: .dateOfBirth)
        if let dateOfBirthString = dateOfBirthString {
            self.dateOfBirth = yyyyMMddDateFormatter.date(from: dateOfBirthString) ?? nil
        } else {
            self.dateOfBirth = nil
        }
        let dateOfDeathString = try container.decode(String?.self, forKey: .dateOfDeath)
        if let dateOfDeathString = dateOfDeathString {
            self.dateOfDeath = yyyyMMddDateFormatter.date(from: dateOfDeathString) ?? nil
        } else {
            self.dateOfDeath = nil
        }
        self.nationality = try container.decode(String?.self, forKey: .nationality)
        self.bio = try container.decode(String?.self, forKey: .bio)
        self.profileImage = try container.decode(String?.self, forKey: .profileImage)
        self.profileImageThumbnail = try container.decode(String?.self, forKey: .profileImageThumbnail)
        let iso8601Formatter = DateFormatter.iso8601Full
        let firstFlightString = try container.decode(String?.self, forKey: .firstFlight)
        if let firstFlightString = firstFlightString {
            self.firstFlight = iso8601Formatter.date(from: firstFlightString) ?? nil
        } else {
            self.firstFlight = nil
        }
    }
}

struct AstronautStatus: Codable {
    let id: Int!
    let name: String?
}


struct AstronautType: Codable {
    let id: Int!
    let name: String?
}
