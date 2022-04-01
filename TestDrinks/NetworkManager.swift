//
//  NetworkManager.swift
//  TestDrinks
//
//  Created by Михаил Малышев on 01.04.2022.
//

import Alamofire
import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchDrinksFrom(_ url: String,with complition: @escaping (Result) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: Result.self) { data in
                switch data.result {
                case .success(let result):
                    complition(result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
