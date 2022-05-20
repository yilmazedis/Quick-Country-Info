//
//  Continents.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import Foundation

struct Countries: Decodable {
    let subregion: String?
    let name: Names
    let flag: String?
    let currencies: [String: [String: String]?]?
    let languages: [String: String]?
    let latlng: [Float]?
}

struct Names: Decodable {
    var common: String
    let nativeName: [String: [String: String]?]?
}
