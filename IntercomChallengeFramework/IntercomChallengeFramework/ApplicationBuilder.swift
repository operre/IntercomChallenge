//
//  ApplicationBuilder.swift
//  IntercomChallengeFramework
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

struct ApplicationBuilder {
    static func makeDownloaderService() -> FileDownloaderServiceProtocol {
        let reader = FileReaderService()
        let parser = FileJSONParser()
        return FileDownloaderService(with: reader, parser)
    }
    
    static func makeDistanceValidator() -> DistanceValidatorProtocol {
        let calculator = DistanceCalculator()
        return DistanceValidator(using: calculator)
    }
}
