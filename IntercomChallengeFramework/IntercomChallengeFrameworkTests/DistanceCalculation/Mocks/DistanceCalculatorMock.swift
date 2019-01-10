//
//  DistanceCalculatorMock.swift
//  IntercomChallengeFrameworkTests
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

@testable import IntercomChallengeFramework

struct DistanceCalculatorMock: DistanceCalculatorProtocol {
    private let testCase: DistanceValidatorTestCase
    
    init(given testCase: DistanceValidatorTestCase) {
        self.testCase = testCase
    }
    
    func calculateDistance(from firstLocation: Location, to secondLocation: Location) -> Double {
        switch self.testCase {
        case .distanceWithinRadius(let radius):
            return radius - 0.1
        case .distanceEqualRadius(let radius):
            return radius
        case .distanceOutOfRadius(let radius):
            return radius + 0.1
        }
    }
}
