//
//  RequestToken.swift
//  GrainChain Test
//
//  Created by Tecnocen on 3/6/19.
//  Copyright © 2019 Ana. All rights reserved.

import UIKit
import Alamofire


struct RequestToken {
    
    // MARK: - Singleton
    static let shared = RequestToken()
    // MARK: - URL
    private var tokenUrl = "https://kdmldkvxoe.execute-api.us-west-2.amazonaws.com/test"
    // MARK: - Services
    mutating func requestToken (username: String,
                                password: String,
                                completion: @escaping (Token?,Error?, String?) -> ()) {
        
        let parameters: Parameters = [
            "username": username,
            "password": password,
            ]
        
        let url = "\(tokenUrl)"
        let request = Alamofire.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default)
        request.responseToken { response in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200  {
                    if let user = response.result.value {
                        completion(user, nil, "")
                        return
                    }
                }
            case .failure(let error):
                if let err = error as? URLError, err.code == .notConnectedToInternet {
                    completion(nil, nil, "No hay conexión a Internet. Para ingresar necesitas una conexión activa a Internet.")
                } else if error._code == NSURLErrorTimedOut {
                    completion(nil, nil, "Ha ocurrido un error al conectarnos con el servidor. Por favor verifica tu conexión a Internet.")
                } else {
                    completion(nil, error, nil)
                }
                return
            }
        }
    }
    
}


