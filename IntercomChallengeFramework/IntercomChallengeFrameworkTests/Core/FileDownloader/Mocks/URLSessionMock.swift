//
//  URLSessionMock.swift
//  IntercomChallengeFrameworkTests
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import XCTest

class URLSessionMock: URLSession {
    private let testCase: FileDownloaderTestCase
    private let expectation: XCTestExpectation?
    
    init(given testCase: FileDownloaderTestCase, _ expectation: XCTestExpectation? = nil) {
        self.testCase = testCase
        self.expectation = expectation
    }
    
    override func downloadTask(with request: URLRequest, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
        var url: URL?
        var error: Error?
        
        switch self.testCase {
        case .downloadWithValidResult, .downloadWithNotReadableResult, .downloadWithNotSerializableResult:
            expectation?.fulfill()
            url = URL(string: "www.google.com")
            error = nil
        case .downloadWithError:
            expectation?.fulfill()
            url = nil
            error = MockedRequestError.anyError
        case .downloadWithoutResult:
            expectation?.fulfill()
            url = nil
            error = nil
        default:
            url = nil
            error = nil
        }
        
        completionHandler(url, nil, error)
        return URLSessionDownloadTaskMock()
    }
}

// MARK: - MockedRequestError

enum MockedRequestError: Error {
    case anyError
}

// MARK: - URLSessionDownloadTaskMock

private class URLSessionDownloadTaskMock: URLSessionDownloadTask {
    override func resume() {}
}
