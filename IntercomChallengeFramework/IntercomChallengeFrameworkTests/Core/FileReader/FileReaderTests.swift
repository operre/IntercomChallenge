//
//  FileReaderTests.swift
//  IntercomChallengeFrameworkTests
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import XCTest
@testable import IntercomChallengeFramework

enum FileReaderTestCase {
    case populatedFile(Data)
    case emptyFile
    case fileDoesNotExist
    case unreadableFile
    case unableToEncodeFile
}

class FileReaderTests: XCTestCase {
    private let anyValidURL = URL(string: "www.google.com")!
    
    func testReadFileWithPopulatedFile() {
        // Given
        let lineContent = "Mocked line content."
        let fileContent = lineContent + "\n" + lineContent
        let fileData = fileContent.data(using: .utf8)
        
        let fileManager = FileManagerMock(given: .populatedFile(fileData!))
        let fileReader = FileReaderService(fileManager: fileManager)

        // When
        let linesOfFile = try! fileReader.readFile(from: self.anyValidURL)
        
        // Then
        linesOfFile.forEach { line in
            XCTAssert(line == lineContent)
        }
        
        XCTAssertTrue(linesOfFile.count == 2)
    }
    
    func testReadFileWithEmptyFile() {
        // Given
        let fileManager = FileManagerMock(given: .emptyFile)
        let fileReader = FileReaderService(fileManager: fileManager)

        // When
        let linesOfFile = try! fileReader.readFile(from: self.anyValidURL)
        
        // Then
        XCTAssertTrue(linesOfFile.count == 0)
    }
    
    func testReadFileWithoutFile() {
        // Given
        let fileManager = FileManagerMock(given: .fileDoesNotExist)
        let fileReader = FileReaderService(fileManager: fileManager)
        let anyValidURL = URL(string: "www.google.com")
        
        // When
        do {
            _ = try fileReader.readFile(from: anyValidURL!)
            XCTFail()
        }
        
        //Then
        catch {
            guard let readError = error as? ReadError else {
                XCTFail()
                return
            }
            
            switch readError {
            case .fileDoesNotExist:
                break
            default:
                XCTFail()
            }
        }
    }
    
    func testReadFileWithUnreadableFile() {
        // Given
        let fileManager = FileManagerMock(given: .unreadableFile)
        let fileReader = FileReaderService(fileManager: fileManager)
        
        // When
        do {
            _ = try fileReader.readFile(from: self.anyValidURL)
            XCTFail()
        }
            
        //Then
        catch {
            guard let readError = error as? ReadError else {
                XCTFail()
                return
            }
            
            switch readError {
            case .unreadableFile:
                break
            default:
                XCTFail()
            }
        }
    }
    
    func testReadFileWithNotEncodableFile() {
        // Given
        let fileContent = "AnyContent"
        let fileData = fileContent.data(using: .utf32)
        
        let fileManager = FileManagerMock(given: .populatedFile(fileData!))
        let fileReader = FileReaderService(fileManager: fileManager)
        
        // When
        do {
            _ = try fileReader.readFile(from: self.anyValidURL)
            XCTFail()
        }
            
        //Then
        catch {
            guard let readError = error as? ReadError else {
                XCTFail()
                return
            }
            
            switch readError {
            case .unableToEncodeFile:
                break
            default:
                XCTFail()
            }
        }
    }
}
