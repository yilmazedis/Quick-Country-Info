//
//  CountriesCaller.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

enum ApiFail: Error {
    case failData
    case failData1
    case failData2
}

class CountriesCaller {
    
    static let shared = CountriesCaller()
    var task: URLSessionDataTask?
    
    func fetchCountries(with urlStr: String, completion: @escaping (Result<[Country], Error>) -> Void) {
        
        guard let urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value as Any).arrayValue
                
                var decodedCountry: [Country] = []
                for el in json {
                                        
                    decodedCountry.append(Country(with: el))
                }
                completion(.success(decodedCountry))
                
                //print("JSON: \(json)")
            case .failure(let error):
                print(error)
                completion(.failure(ApiFail.failData))
            }
        }
    }
    
//    func fetchCountries(with urlStr: String, completion: @escaping (Result<[Country], Error>) -> Void) {
//
//        guard let urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
//            return
//        }
//
//        guard let url = URL(string: urlStr) else {
//            return
//        }
//
//        task?.cancel()
//
//        task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
//
//            guard let data = data else {
//                completion(.failure(ApiFail.failData1))
//                return
//            }
//
//            guard error == nil else {
//                completion(.failure(ApiFail.failData2))
//                return
//            }
//
//            do {
//                let result = try JSONDecoder().decode([Country].self, from: data)
//                completion(.success(result))
//            } catch {
//                completion(.failure(ApiFail.failData))
//            }
//        }
//
//        task?.resume()
//    }
}
