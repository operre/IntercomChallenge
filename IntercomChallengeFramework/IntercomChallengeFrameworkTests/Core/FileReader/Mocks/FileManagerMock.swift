//
//  FileManagerMock.swift
//  IntercomChallengeFrameworkTests
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

class FileManagerMock: FileManager {
    private let testCase: FileReaderTestCase
    
    init(given testCase: FileReaderTestCase) {
        self.testCase = testCase
    }
    
    override func fileExists(atPath path: String) -> Bool {
        switch self.testCase {
        case .fileDoesNotExist:
            return false
        default:
            return true
        }
    }
    
    override func isReadableFile(atPath path: String) -> Bool {
        switch self.testCase {
        case .unreadableFile:
            return false
        default:
            return true
        }
    }
    
    override func contents(atPath path: String) -> Data? {
        switch self.testCase {
        case .populatedFile(let fileData):
            return fileData
        case .emptyFile:
            return Data()
        default:
            return nil
        }
    }
}
