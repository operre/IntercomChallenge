//
//  FileReaderServiceMock.swift
//  IntercomChallengeFrameworkTests
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import XCTest
@testable import IntercomChallengeFramework

struct FileReaderServiceMock: FileReaderServiceProtocol {
    private let testCase: FileDownloaderTestCase
    private let expectation: XCTestExpectation?
    
    init(given testCase: FileDownloaderTestCase, _ expectation: XCTestExpectation? = nil) {
        self.testCase = testCase
        self.expectation = expectation
    }
    
    func readFile(from origin: URL) throws -> [String] {
        switch self.testCase {
        case .downloadWithValidResult, .downloadWithNotSerializableResult:
            expectation?.fulfill()
            return [""]
        case .downloadWithNotReadableResult:
            expectation?.fulfill()
            throw MockedFileReadError.anyError
        default:
            throw MockedFileReadError.anyError
        }
    }
}

enum MockedFileReadError: Error {
    case anyError
}
