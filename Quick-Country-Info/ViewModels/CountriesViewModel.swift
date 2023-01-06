//
//  CountriesViewModel.swift
//  CountryApp
//
//  Created by yilmaz on 23.05.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

final class CountriesViewModel {
    
    private var countries: [Country] = []
    
    func fetchCountries(with urlStr: String, completion: @escaping () -> Void) {
        
        guard let urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
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
    
    private func load(with json: [JSON]) {
        for el in json {
            countries.append(Country(with: el))
        }
    }
    
    private func unload() {
        countries = []
    }
    
    func getCountry(at index: Int) -> Country {
        return countries[index]
    }
    
    func getCountryCount() -> Int {
        return countries.count
    }
}
