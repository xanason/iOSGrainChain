//
//  tokenModel.swift
//  GrainChain Test
//
//  Created by Tecnocen on 3/6/19.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import Realm


@objcMembers class Token : Object, Decodable {
    dynamic var statusCode : Int?
    dynamic var body: Body? = Body()
    
    enum CodingKeys: String, CodingKey {
        
        case statusCode = "statusCode"
        case body = "body"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        body = try values.decodeIfPresent(Body.self, forKey: .body)
        
        super.init()
    }
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
}
@objcMembers class Body : Object, Decodable {
    dynamic var status : String?
    dynamic var auth: Auth? = Auth()
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case auth = "auth"
    }
    
    required  init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        auth = try values.decodeIfPresent(Auth.self, forKey: .auth)
        
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    
    
}
@objcMembers class Auth : Object, Decodable {
    dynamic var user: User? = User()
    dynamic var access_token : String?
    
    enum CodingKeys: String, CodingKey {
        
        case user = "user"
        case access_token = "access_token"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
        
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
}
@objcMembers class User : Object, Decodable {
    dynamic var name : String?
    dynamic var lastname : String?
    dynamic var email : String?
    dynamic var address : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case lastname = "lastname"
        case email = "email"
        case address = "address"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        
        super.init()
    }
    
    override class func primaryKey() -> String? {
        return "name"
    }

    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    
}

// MARK: - Alamofire response handlers
extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseToken(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Token>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

