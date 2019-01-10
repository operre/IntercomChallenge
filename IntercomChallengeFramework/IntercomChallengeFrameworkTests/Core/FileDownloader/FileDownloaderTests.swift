//
//  FileDownloaderTests.swift
//  IntercomChallengeFrameworkTests
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import XCTest
@testable import IntercomChallengeFramework

enum FileDownloaderTestCase {
    case invalidURL
    case downloadWithError
    case downloadWithoutResult
    case downloadWithNotReadableResult
    case downloadWithNotSerializableResult
    case downloadWithValidResult([Customer])
}

class FileDownloaderTests: XCTestCase {
    
    func testDownloadWithInvalidURL() {
        // Given
        let testCase: FileDownloaderTestCase = .invalidURL
        
        let reader = FileReaderServiceMock(given: testCase)
        let parser = FileJSONParserMock(given: testCase)
        let session = URLSessionMock(given: testCase)
        let fileDownloader = FileDownloaderService(with: reader, parser, session)
        
        let invalidURLString = ""
        
        // When
        fileDownloader.download(from: invalidURLString, responseType: Customer.self) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .error(let error):
                // Then
                guard let downloadError = error as? DownloadError, downloadError == .invalidURL else {
                    XCTFail()
                    return
                }
            }
        }
    }
    
    func testDownloadWithError() {
        // Given
        let testCase: FileDownloaderTestCase = .downloadWithError
        let sessionExpectation = XCTestExpectation(description: "Download with error.")
        
        let reader = FileReaderServiceMock(given: testCase)
        let parser = FileJSONParserMock(given: testCase)
        let session = URLSessionMock(given: testCase, sessionExpectation)
        let fileDownloader = FileDownloaderService(with: reader, parser, session)
        
        let anyValidURLString = "www.google.com"
        
        // When
        fileDownloader.download(from: anyValidURLString, responseType: Customer.self) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .error(let error):
                // Then
                guard let mockedRequestError = error as? MockedRequestError, mockedRequestError == .anyError else {
                    XCTFail()
                    return
                }
            }
        }
        
        // Then
        wait(for: [sessionExpectation], timeout: 0.1)
    }
    
    func testDownloadWithoutResult() {
        // Given
        let testCase: FileDownloaderTestCase = .downloadWithoutResult
        let sessionExpectation = XCTestExpectation(description: "Download without result.")
        
        let reader = FileReaderServiceMock(given: testCase)
        let parser = FileJSONParserMock(given: testCase)
        let session = URLSessionMock(given: testCase, sessionExpectation)
        let fileDownloader = FileDownloaderService(with: reader, parser, session)
        
        let anyValidURLString = "www.google.com"
        
        // When
        fileDownloader.download(from: anyValidURLString, responseType: Customer.self) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .error(let error):
                // Then
                guard let downloadError = error as? DownloadError, downloadError == .unableToDownload else {
                    XCTFail()
                    return
                }
            }
        }
        
        // Then
        wait(for: [sessionExpectation], timeout: 0.1)
    }
    
    func testDownloadWithNotReadableResult() {
        // Given
        let testCase: FileDownloaderTestCase = .downloadWithNotReadableResult
        
        let readerExpectation = XCTestExpectation(description: "Download with not readable result.")
        let sessionExpectation = XCTestExpectation(description: "Download with not readable result.")
        
        let reader = FileReaderServiceMock(given: testCase, readerExpectation)
        let parser = FileJSONParserMock(given: testCase)
        let session = URLSessionMock(given: testCase, sessionExpectation)
        let fileDownloader = FileDownloaderService(with: reader, parser, session)
        
        let anyValidURLString = "www.google.com"
        
        // When
        fileDownloader.download(from: anyValidURLString, responseType: Customer.self) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .error(let error):
                // Then
                guard let mockedFileReadError = error as? MockedFileReadError, mockedFileReadError == .anyError else {
                    XCTFail()
                    return
                }
            }
        }
        
        // Then
        wait(for: [readerExpectation, sessionExpectation], timeout: 0.1)
    }
    
    func testDownloadWithNotSerializableResult() {
        // Given
        let testCase: FileDownloaderTestCase = .downloadWithNotSerializableResult
        
        let readerExpectation = XCTestExpectation(description: "Download with not serializable result.")
        let parserExpectation = XCTestExpectation(description: "Download with not serializable result.")
        let sessionExpectation = XCTestExpectation(description: "Download with not serializable result.")
        
        let reader = FileReaderServiceMock(given: testCase, readerExpectation)
        let parser = FileJSONParserMock(given: testCase, parserExpectation)
        let session = URLSessionMock(given: testCase, sessionExpectation)
        let fileDownloader = FileDownloaderService(with: reader, parser, session)
        
        let anyValidURLString = "www.google.com"
        
        // When
        fileDownloader.download(from: anyValidURLString, responseType: Customer.self) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .error(let error):
                // Then
                guard let parseError = error as? ParseError, parseError == .unableToSerialize else {
                    XCTFail()
                    return
                }
            }
        }
        
        // Then
        wait(for: [readerExpectation, parserExpectation, sessionExpectation], timeout: 0.1)
    }

    func testDownloadWithValidResult() {
        // Given
        let mockedResult = [Customer(userID: 1, name: "Test", location: Location(latitude: 1, longitude: 1))]
        let testCase: FileDownloaderTestCase = .downloadWithValidResult(mockedResult)
        
        let readerExpectation = XCTestExpectation(description: "Download with valid result.")
        let parserExpectation = XCTestExpectation(description: "Download with valid result.")
        let sessionExpectation = XCTestExpectation(description: "Download with valid result.")
        
        let reader = FileReaderServiceMock(given: testCase, readerExpectation)
        let parser = FileJSONParserMock(given: testCase, parserExpectation)
        let session = URLSessionMock(given: testCase, sessionExpectation)
        let fileDownloader = FileDownloaderService(with: reader, parser, session)
        
        let anyValidURLString = "www.google.com"
        
        // When
        fileDownloader.download(from: anyValidURLString, responseType: Customer.self) { result in
            switch result {
            case .success(let result):
                // Then
                XCTAssertTrue(result == mockedResult)
            case .error(_):
                XCTFail()
            }
        }
        
        // Then
        wait(for: [readerExpectation, parserExpectation, sessionExpectation], timeout: 0.1)
    }
}
