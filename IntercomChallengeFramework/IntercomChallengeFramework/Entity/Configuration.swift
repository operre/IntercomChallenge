//
//  Configuration.swift
//  IntercomChallengeFramework
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

public struct Configuration {
    var downloadURL: String
    var allowedRadius: Double
    var location: Location
    
    public init() {
        self.downloadURL = "https://s3.amazonaws.com/intercom-take-home-test/customers.txt"
        self.allowedRadius = 100
        self.location = Location(latitude: 53.339428, longitude: -6.257664)
    }
    
    public init(downloadURL: String, allowedRadius: Double, location: Location) {
        self.downloadURL = downloadURL
        self.allowedRadius = allowedRadius
        self.location = location
    }
}
