//
//  DetailCountryViewModel.swift
//  CountryApp
//
//  Created by yilmaz on 23.05.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

final class DetailCountryViewModel {
    
    private var country: Country = Country()
    private let sectionTitles = ["Flag",
                                 "Currency Units",
                                 "Languages",
                                 "Map"]
    
    static let shared = DetailCountryViewModel()
    
    func setCountry(with country: Country) {
        self.country = country
    }
    
    func getCountry() -> Country {
        return country
    }
    
    func getSection(at index: Int) -> String {
        return sectionTitles[index]
    }
    
    func getSectionCount() -> Int {
        return sectionTitles.count
    }
}
