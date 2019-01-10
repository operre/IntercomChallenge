//
//  FileJSONParserMock.swift
//  IntercomChallengeFrameworkTests
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import XCTest
@testable import IntercomChallengeFramework

struct FileJSONParserMock: FileJSONParserProtocol {
    private let testCase: FileDownloaderTestCase
    private let expectation: XCTestExpectation?
    
    init(given testCase: FileDownloaderTestCase, _ expectation: XCTestExpectation? = nil) {
        self.testCase = testCase
        self.expectation = expectation
    }
    
    func parse<T>(lines: [String]) -> [T]? where T : Decodable {
        switch self.testCase {
        case .downloadWithValidResult(let result):
            expectation?.fulfill()
            return result as? [T]
        case .downloadWithNotSerializableResult:
            expectation?.fulfill()
            return nil
        default:
            return nil
        }
    }
}
