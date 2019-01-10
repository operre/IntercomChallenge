//
//  Customer.swift
//  IntercomChallengeFramework
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

struct Customer: Localizable {
    let userID: Int
    let name: String
    var location: Location
}

// MARK: - Decodable

extension Customer: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let latitudeString = try values.decode(String.self, forKey: .latitude)
        let longitudeString = try values.decode(String.self, forKey: .longitude)
        
        guard let latitude = Double(latitudeString), let longitude = Double(longitudeString) else {
            throw ParseError.unableToSerialize
        }
        
        self.location = Location(latitude: latitude, longitude: longitude)
        self.userID = try values.decode(Int.self, forKey: .userID)
        self.name = try values.decode(String.self, forKey: .name)
    }
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name
        case latitude
        case longitude
    }
}
