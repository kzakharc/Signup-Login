//
//  Request.swift
//  JBW-Zakharchuk
//
//  Created by Kateryna Zakharchuk on 3/1/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation
import Alamofire

class Request {
    var userInfo = UserStruct()
    var token: String?
    
    func signUpRequest(user: UserStruct, completion: @escaping (NSDictionary?, Error?) -> Void) {
        let parameters = ["name": user.name, "email": user.email, "password": user.password]
        let url = "https://apiecho.cf/api/signup/"
        
        Alamofire.request(url, method:.post, parameters:parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                self.checkingForResponse(response: response, completion: completion)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func logInRequest(user: UserStruct, completion: @escaping (NSDictionary?, Error?) -> Void) {
        let parameters = ["email": user.email, "password": user.password]
        let url = "https://apiecho.cf/api/login/"
        
        Alamofire.request(url, method:.post, parameters:parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                self.checkingForResponse(response: response, completion: completion)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getInfo(completion: @escaping (NSDictionary?, Error?) -> Void) {
        let url = "http://apiecho.cf/api/get/text/"
        let headers = [
            "Accept": "application/json",
            "content-type": "application/json",
            "Authorization": "Bearer " + self.token!
        ]
        Alamofire.request(url, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    self.checkingForResponse(response: response, completion: completion)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    private func checkingForResponse(response: DataResponse<Any>, completion: @escaping (NSDictionary?, Error?) -> Void) {
        print("Success from NetworkManager")
        if let result = response.result.value {
            completion(result as? NSDictionary, nil)
        }
    }
}
