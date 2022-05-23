//
//  Continents.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import Foundation
import SwiftyJSON

typealias CurrencyTuple = (name: String, symbol: String)
typealias LocationTuple = (lat: Float, lng: Float)

struct Country {
    let name: String
    let nativeName: String
    let subregion: String
    let flag: String
    let currencies: [CurrencyTuple]
    let languages: [String]
    let location: LocationTuple
    
    // Default init
    init() {
        self.name = ""
        self.nativeName = ""
        self.subregion = ""
        self.flag = ""
        self.currencies = [CurrencyTuple(name: "", symbol: "")]
        self.languages = [""]
        self.location = LocationTuple(lat: 0.0, lng: 0.0)
    }
    
    init(with data: JSON) {
        self.name = data["name"]["common"].stringValue
        self.nativeName = Country.setNativeName(with: data)
        self.subregion = data["subregion"].stringValue
        self.flag = data["flag"].stringValue
        self.currencies = Country.setCurrency(with: data)
        self.languages = Country.setLanguages(with: data)
        self.location = Country.setlatAndlng(with: data)
    }
    
    private static func setNativeName(with data: JSON) -> String {
        guard let key = data["name"]["nativeName"].dictionaryObject?.keys.first else {
            return ""
        }
        
        let common = data["name"]["nativeName"][key]["common"].stringValue
        return common
    }
    
    private static func setCurrency(with data: JSON) -> [CurrencyTuple] {
        guard let keys = data["currencies"].dictionaryObject?.keys else {
            return []
        }
        
        var currencies: [CurrencyTuple] = []
        
        for key in keys {
            let name = data["currencies"][key]["name"].stringValue
            let symbol = data["currencies"][key]["symbol"].stringValue
            
            currencies.append(CurrencyTuple(name: name, symbol: symbol))
        }
        
        return currencies
    }
    
    private static func setLanguages(with data: JSON) -> [String] {
        guard let keys = data["languages"].dictionaryObject?.keys else {
            return []
        }
        
        var languages: [String] = []
        
        for key in keys {
            let language = data["languages"][key].stringValue
            languages.append(language)
        }
        
        return languages
    }
    
    private static func setlatAndlng(with data: JSON) -> LocationTuple {
        let lat = data["latlng"].arrayValue[0].floatValue
        let lng = data["latlng"].arrayValue[1].floatValue
        return LocationTuple(lat: lat, lng: lng)
    }
}
