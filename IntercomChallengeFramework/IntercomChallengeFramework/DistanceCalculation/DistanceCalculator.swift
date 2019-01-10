//
//  DistanceCalculator.swift
//  IntercomChallengeFramework
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

protocol DistanceCalculatorProtocol {
    func calculateDistance(from firstLocation: Location, to secondLocation: Location) -> Double
}

struct DistanceCalculator: DistanceCalculatorProtocol {
    private let earthRadius: Double = 6372
    
    func calculateDistance(from firstLocation: Location, to secondLocation: Location) -> Double {
        let pointX = firstLocation.toRadians()
        let pointY = secondLocation.toRadians()
        
        let deltaLongitude = abs(pointY.longitude - pointX.longitude)
        let deltaLatitude =
            acos(sin(pointX.latitude) *
                sin(pointY.latitude) +
                cos(pointX.latitude) *
                cos(pointY.latitude) *
                cos(deltaLongitude))

        let distance = self.earthRadius * deltaLatitude
        return distance
    }
}
