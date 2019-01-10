//
//  DistanceValidatorTests.swift
//  IntercomChallengeFrameworkTests
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import XCTest
@testable import IntercomChallengeFramework

enum DistanceValidatorTestCase {
    case distanceWithinRadius(Double)
    case distanceOutOfRadius(Double)
    case distanceEqualRadius(Double)
}

class DistanceValidatorTests: XCTestCase {
    private let mockedLocation = Location(latitude: 0, longitude: 0)
    private let radius: Double = 100
    
    func testFilterWithDistanceWithinRadius() {
        // Given
        let calculator = DistanceCalculatorMock(given: .distanceWithinRadius(self.radius))
        let distanceValidator = DistanceValidator(using: calculator)
        
        let mockedPoints = [
            AnyLocalizableEntity(location: self.mockedLocation),
            AnyLocalizableEntity(location: self.mockedLocation)
        ]
        
        // When
        let validPoints = distanceValidator.filter(points: mockedPoints,
                                                   within: self.radius,
                                                   given: self.mockedLocation)
        
        // Then
        XCTAssertTrue(validPoints.count == mockedPoints.count)
    }
    
    func testFilterWithDistanceEqualRadius() {
        // Given
        let calculator = DistanceCalculatorMock(given: .distanceEqualRadius(self.radius))
        let distanceValidator = DistanceValidator(using: calculator)
        
        let mockedPoints = [
            AnyLocalizableEntity(location: mockedLocation)
        ]
        
        // When
        let validPoints = distanceValidator.filter(points: mockedPoints,
                                                   within: self.radius,
                                                   given: self.mockedLocation)
        
        // Then
        XCTAssertTrue(validPoints.count == mockedPoints.count)
    }

    func testFilterWithDistanceOutOfRadius() {
        // Given
        let calculator = DistanceCalculatorMock(given: .distanceOutOfRadius(self.radius))
        let distanceValidator = DistanceValidator(using: calculator)

        let mockedPoints = [
            AnyLocalizableEntity(location: mockedLocation),
            AnyLocalizableEntity(location: mockedLocation),
            AnyLocalizableEntity(location: mockedLocation)
        ]
        
        // When
        let validPoints = distanceValidator.filter(points: mockedPoints,
                                                   within: self.radius,
                                                   given: self.mockedLocation)
        
        // Then
        XCTAssertTrue(validPoints.isEmpty)
    }
}
