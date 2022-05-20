//
//  Continents.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import Foundation

struct Countries: Decodable {
    let subregion: String
    let name: Names
    let flags: Flags
    let flag: String
    let currencies: [String: [String: String]]
    let languages: [String: String]
}

struct Names: Decodable {
    let common: String
    let nativeName: [String: [String: String]]
}

struct Flags: Decodable {
    let png: String
}
