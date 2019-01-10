//
//  ApplicationFacade.swift
//  IntercomChallengeFramework
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

public struct ApplicationFacade {
    public static func solveIntercomChallenge(using configuration: Configuration = Configuration(),
                                              callback: @escaping (Result<[(Int, String)]>) -> Void) {
        let downloader = ApplicationBuilder.makeDownloaderService()
        let distanceValidator = ApplicationBuilder.makeDistanceValidator()
        
        downloader.download(from: configuration.downloadURL, responseType: Customer.self) { result in
            switch result {
            case .success(let customers):
                guard let customers = customers else {
                    callback(.error(nil))
                    return
                }
                
                let validCustomers = distanceValidator.filter(points: customers,
                                                              within: configuration.allowedRadius,
                                                              given: configuration.location)
                let formattedValidCustomers = validCustomers.sorted().map { customer in
                    (customer.userID, customer.name)
                }
                
                callback(.success(formattedValidCustomers))
            case .error(let error):
                callback(.error(error))
            }
        }
    }
}
