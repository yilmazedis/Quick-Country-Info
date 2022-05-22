//
//  Continents.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import Foundation
import SwiftyJSON

typealias CurrencyTuple = (name: String, symbol: String)

struct Country {
    let name: String
    let nativeName: String
    let subregion: String
    let flag: String
    let currencies: [CurrencyTuple]
    let languages: [String]
    let latlng: [Float]
    
    init(with data: JSON) {
        self.name = data["name"]["common"].stringValue
        
        self.nativeName = Country.setNativeName(with: data)
        
        self.subregion = data["subregion"].stringValue
        self.flag = data["flag"].stringValue
        
        self.currencies = Country.setCurrency(with: data)
        
        self.languages = Country.setLanguages(with: data)
        
        self.latlng = Country.setlatAndlng(with: data)
    }
    
    private static func setNativeName(with data: JSON) -> String {
        guard let native = data["name"]["nativeName"].dictionaryObject else {
            return ""
        }
        
        guard let key = native.keys.first else {
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
    
    private static func setlatAndlng(with data: JSON) -> [Float] {
        let lat = data["latlng"].arrayValue[0].floatValue
        let lng = data["latlng"].arrayValue[1].floatValue
        return [lat, lng]
    }
}
