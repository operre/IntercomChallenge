//
//  DistanceCalculatorTests.swift
//  IntercomChallengeFrameworkTests
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import XCTest
@testable import IntercomChallengeFramework

class DistanceCalculatorTests: XCTestCase {
    private let distanceCalculator: DistanceCalculator = DistanceCalculator()

    func testCalculateDistanceWithTwoLocations() {
        // Given
        let firstLocation = Location(latitude: 53.339428, longitude: -6.257664)
        let secondLocation = Location(latitude: 52.986375, longitude: -6.043701)
        
        // When
        let distance = self.distanceCalculator.calculateDistance(from: firstLocation, to: secondLocation)
        
        // Then
        let distanceFormatted = String(format: "%.2f", distance)
        XCTAssertTrue(distanceFormatted == "41.78")
    }

    func testCalculateDistanceWithSameLocation() {
        // Given
        let location = Location(latitude: 53.339428, longitude: -6.257664)
        
        // When
        let distance = self.distanceCalculator.calculateDistance(from: location, to: location)
        
        // Then
        XCTAssertTrue(distance == 0)
    }
}
