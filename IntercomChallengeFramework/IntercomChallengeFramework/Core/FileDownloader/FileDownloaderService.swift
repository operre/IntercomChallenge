//
//  FileDownloaderService.swift
//  IntercomChallengeFramework
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

protocol FileDownloaderServiceProtocol {
    func download<T: Decodable>(from fileURL: String, responseType: T.Type, handler: @escaping (Result<[T]>) -> Void)
}

struct FileDownloaderService: FileDownloaderServiceProtocol {
    private let reader: FileReaderServiceProtocol
    private let parser: FileJSONParserProtocol
    private let session: URLSession
    
    init(with reader: FileReaderServiceProtocol,
         _ parser: FileJSONParserProtocol,
         _ session: URLSession = URLSession.shared) {
        self.parser = parser
        self.reader = reader
        self.session = session
    }
    
    func download<T: Decodable>(from fileURL: String, responseType: T.Type, handler: @escaping (Result<[T]>) -> Void) {
        guard let url = URL(string: fileURL) else {
            handler(.error(DownloadError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        let dataTask = self.session.downloadTask(with: request) { (localURL, _, error) in
            guard error == nil else {
                handler(.error(error!))
                return
            }
            
            guard let localURL = localURL else {
                handler(.error(DownloadError.unableToDownload))
                return
            }
            
            do {
                let file = try self.reader.readFile(from: localURL)
                
                guard let result: [T] = self.parser.parse(lines: file) else {
                    handler(.error(ParseError.unableToSerialize))
                    return
                }
                
                handler(.success(result))
            } catch {
                handler(.error(error))
            }
        }
        dataTask.resume()
    }
}
