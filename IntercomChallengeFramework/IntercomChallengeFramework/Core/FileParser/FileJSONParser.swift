//
//  FileJSONParser.swift
//  IntercomChallengeFramework
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

protocol FileJSONParserProtocol {
    func parse<T: Decodable>(lines: [String]) -> [T]?
}

struct FileJSONParser: FileJSONParserProtocol {
    func parse<T: Decodable>(lines: [String]) -> [T]? {
        let entities = lines.compactMap { line -> T? in
            guard let data = line.data(using: .utf8),
                let entity: T = self.parse(from: data) else {
                    return nil
            }
            
            return entity
        }
        
        guard !entities.isEmpty else {
            return nil
        }
        
        return entities
    }
    
    private func parse<T: Decodable>(from data: Data) -> T? {
        let decoder = JSONDecoder()
        guard let entity = try? decoder.decode(T.self, from: data) else {
            return nil
        }
        
        return entity
    }
}
