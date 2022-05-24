//
//  ContinentsViewModel.swift
//  CountryApp
//
//  Created by yilmaz on 23.05.2022.
//

import Foundation

final class ContinentsViewModel {
    
    private let continents = [ "Asia",
                               "Europe",
                               "Africa",
                               "North America",
                               "South America",
                               "Oceania" ]
    
    static let shared = ContinentsViewModel()
    
    func getContinent(at index: Int) -> String {
        return continents[index]
    }
    
    func getContinentCount() -> Int {
        return continents.count
    }
}
