//
//  NetworkError.swift
//  Marvel Heroes
//
//  Created by Никита on 13.11.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case failInternetError
    case failGetJSON
    case failParseJSON
}
