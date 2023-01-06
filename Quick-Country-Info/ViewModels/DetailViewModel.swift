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
    private ( set ) var cellHight = K.cellHight
    
    private let sectionTitles = ["Flag",
                                 "Currency Units",
                                 "Languages",
                                 "Map"]
        
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
    
    func setCellHight(when section: CellSections) {
        switch section {
        case .flag:
            cellHight = K.DetailView.flagCellHight
        case .curency:
            cellHight = K.cellHight
        case .languages:
            cellHight = K.cellHight
        case .map:
            cellHight = K.DetailView.mapCellHight
        }
    }
}
