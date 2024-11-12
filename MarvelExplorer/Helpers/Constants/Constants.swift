//
//  Constants.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 11/11/2024.
//

import Foundation


enum Constants {
    enum Networking {
        static var baseURL: String {
            return  "https://gateway.marvel.com/v1/public"
        }
        static var publicKey: String {
            return "f16531010cb46266ea7de699dcbdc379"
        }
        
        static var privateKey: String {
            return "a176e22545232c02696b6695413423f81792f28f"
        }
    }
}
