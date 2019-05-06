//
//  NetworkManager.swift
//  mental_health_proj
//
//  Created by Jiehong Lin on 5/4/19.
//  Copyright © 2019 Mitchell Lin. All rights reserved.
//

import Foundation
import Alamofire

let endpoint = "http://35.245.75.53/"

class NetworkManager {
//    static func getInfo() {
//        Alamofire.request(endpoint, method: .get).validate().responseData { (response) in
//            switch response.result{
//            case .success(let data):
//                print("succeed")
//                if let json = try? JSONSerialization.jsonObject(with: data, options: []){
//                    print(json)
//
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//                print("bad")
//            }
//        }
//    }
    static func getInfo(completion: @escaping ([locationStruct]) -> Void) {
        Alamofire.request(endpoint, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let response = try? jsonDecoder.decode(locationResponse.self, from: data) {
                    completion(response.data)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
