//
//  NetworkError.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 31/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Encoding parameters went wrong"
    case missingUrl = "Url is missing"
    case failedBuildRequest = "There was an issue building request"
}
