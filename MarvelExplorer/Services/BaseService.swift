//
//  BaseService.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 11/11/2024.
//

import Foundation
import Moya

protocol BaseService: TargetType {}

extension BaseService {
    var baseURL: URL {
        return URL(string: Constants.Networking.baseURL)!
    }

    var headers: [String: String]? {
        var headers = [
            "Content-type": "application/json",
        ]

        return headers
    }

    var sampleData: Data {
        Data()
    }
}
