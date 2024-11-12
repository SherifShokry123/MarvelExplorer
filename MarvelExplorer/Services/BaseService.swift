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
        //let authorization = Keychain.userToken
        // NOTE: - In case of an incident specific to a locale, you can change this
        // to anything, for now it's defaulted to GB, but we can change it from RemoteConfig now or
        // anything in the future if needed la qadar allah
        //let locale: String = //UserSettings.shared.country.value.regionCode
        var headers = [
            "Content-type": "application/json",
          //  "locale": locale,
          //  "lang": "\(UserSettings.shared.language.value.languageCode)",
          //  "x-apikey": Constants.Networking.apigeeApiKey,
        ]
//        if let authorization = authorization {
//            headers["Authorization"] = "Bearer \(authorization)"
//        }

        return headers
    }

    var sampleData: Data {
        Data()
    }
}
