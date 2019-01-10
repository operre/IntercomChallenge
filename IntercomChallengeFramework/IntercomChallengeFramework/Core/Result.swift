//
//  Result.swift
//  IntercomChallengeFramework
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T?)
    case error(Error?)
}
