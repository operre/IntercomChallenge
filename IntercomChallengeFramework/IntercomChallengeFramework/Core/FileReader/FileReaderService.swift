//
//  FileReaderService.swift
//  IntercomChallengeFramework
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

protocol FileReaderServiceProtocol {
    func readFile(from origin: URL) throws -> [String]
}

struct FileReaderService: FileReaderServiceProtocol {
    private let fileManager: FileManager
    
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    func readFile(from origin: URL) throws -> [String] {
        guard self.fileManager.fileExists(atPath: origin.path) else {
            throw ReadError.fileDoesNotExist
        }
        
        guard self.fileManager.isReadableFile(atPath: origin.path) else {
            throw ReadError.unreadableFile
        }
        
        guard let fileContentData = self.fileManager.contents(atPath: origin.path),
            let fileContent = String(bytes: fileContentData, encoding: .utf8) else {
                throw ReadError.unableToEncodeFile
        }
        
        let formattedFileContent = format(fileContent: fileContent)
        return formattedFileContent
    }
    
    private func format(fileContent: String) -> [String] {
        var lines = fileContent.components(separatedBy: .newlines)
        
        if let lastLine = lines.last, lastLine == "" {
            lines.removeLast()
        }
        
        return lines
    }
}
