//
//  DistanceValidator.swift
//  IntercomChallengeFramework
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

protocol DistanceValidatorProtocol {
    func filter<T: Localizable>(points: [T], within allowedRadius: Double, given location: Location) -> [T]
}

struct DistanceValidator: DistanceValidatorProtocol {
    private let distanceCalculator: DistanceCalculatorProtocol
    
    init(distanceCalculator: DistanceCalculatorProtocol) {
        self.distanceCalculator = distanceCalculator
    }
    
    func filter<T: Localizable>(points: [T], within allowedRadius: Double, given location: Location) -> [T] {
        let result = points.filter { point in
            let distanceBetweenLocations = self.distanceCalculator.calculateDistance(from: point.location, to: location)
            return distanceBetweenLocations <= allowedRadius
        }
        return result
    }
}
