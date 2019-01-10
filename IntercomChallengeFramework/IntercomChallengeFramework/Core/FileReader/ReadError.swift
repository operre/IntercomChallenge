//
//  ReadError.swift
//  IntercomChallengeFramework
//
//  Created by Ohanna Perre on 10/01/2019.
//  Copyright © 2019 Ohanna Perre. All rights reserved.
//

import Foundation

enum ReadError: Error {
    case unreadableFile
    case fileDoesNotExist
    case unableToEncodeFile
}
