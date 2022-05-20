//
//  CountryNames.swift
//  CountryApp
//
//  Created by yilmaz on 20.05.2022.
//

import Foundation

struct CountryNames: Decodable {
    let name: OnlyNames
    let subregion: String?
}

struct OnlyNames: Decodable {
    let common: String?
}
