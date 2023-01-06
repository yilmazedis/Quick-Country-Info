//
//  SearchCountryViewModel.swift
//  CountryApp
//
//  Created by yilmaz on 23.05.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

final class SearchCountryViewModel {
    
    private var countries: [Country] = []
    private var countryNameAvailabilityWorkItem: DispatchWorkItem?
    
    func fetchCountries(with urlStr: String, completion: @escaping () -> Void) {
        
        guard let urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        let workItem: DispatchWorkItem = DispatchWorkItem {
            AF.request(url, method: .get).response { [weak self] payload in
                
                guard let self = self else {
                    return
                }
                
                switch payload.result {
                case .success(let value):
                    
                    let json = JSON(value as Any).arrayValue
                    
                    self.unload()
                    self.load(with: json)
                    
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        countryNameAvailabilityWorkItem = workItem
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(200), execute: workItem)
    }
    
    private func load(with json: [JSON]) {
        for el in json {
            countries.append(Country(with: el))
        }
    }
    
    func unload() {
        countries = []
    }
    
    func getCountry(at index: Int) -> Country {
        return countries[index]
    }
    
    func getCountryCount() -> Int {
        return countries.count
    }
}
