//
//  DetailViewModel.swift
//  CountryApp
//
//  Created by yilmaz on 23.05.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

final class DetailViewModel {
    
    private var country: Country = Country()
    private let sectionTitles = ["Flag",
                                 "Currency Units",
                                 "Languages",
                                 "Map"]
    private let cellHight: [String: Float] = ["flag": 80,
                                               "text": 40,
                                               "map": 300]
    
    static let shared = DetailViewModel()
    
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
    
    func getCellHight(for cell: String) -> Float {
        return cellHight[cell] ?? 40
    }
}
