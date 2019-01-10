//
//  Location.swift
//  IntercomChallengeFramework
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

public struct Location: Decodable {
    var latitude: Double
    var longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func toRadians() -> Location {
        let latitude = Measurement(value: self.latitude, unit: UnitAngle.degrees).converted(to: .radians).value
        let longitude = Measurement(value: self.longitude, unit: UnitAngle.degrees).converted(to: .radians).value
        
        return Location(latitude: latitude, longitude: longitude)
    }
}
