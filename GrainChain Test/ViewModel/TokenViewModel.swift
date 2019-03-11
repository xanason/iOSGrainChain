//
//  TokenViewModel.swift
//  GrainChain Test
//
//  Created by Tecnocen on 3/7/19.
//  Copyright © 2019 Ana. All rights reserved.
//


import Foundation
import Alamofire
import RealmSwift


extension TokenViewModel {
    static var DEFAULTS_KEY_REMEMBER_EMAIL = "DEFAULTS_KEY_REMEMBER_EMAIL"
}

class TokenViewModel {
    
    // MARK: - Properties
    private var token: Token? {
        didSet {
            guard let token = token else { return }
            self.setupText(with: token)
        }
    }
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var errorMessage: String? = "" {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    //MARK: - UserDefaults variable
    var userDefaults = UserDefaults.self
    
    //MARK: - ViewModel variables
    
    var user : User?
    var userName : String?
    var userEmail:String = ""
    
    // MARK: - Constructor
    init() {
        
        self.userEmail = UserDefaults.standard.string(forKey: TokenViewModel.DEFAULTS_KEY_REMEMBER_EMAIL) ?? ""
    }
    
    
    
    private var dataService: RequestToken?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    var unauthorized: (() -> ())?
    var noUsersFound: (() -> ())?
    
    // MARK: - Constructor
    init(dataService: RequestToken) {
        self.dataService = dataService
    }
    
    // MARK: - Network call
    func requestToken(username: String, password: String) {
        self.dataService?.requestToken(username: username,
                                       password: password,
                                       completion: { (token, error, errorMessage) in
                                        if let error = error {
                                            self.errorMessage = error.localizedDescription
                                            self.error = error
                                            self.isLoading = false
                                            return
                                        }
                                        if errorMessage != "" {
                                            self.errorMessage = errorMessage
                                            self.error = nil
                                            self.isLoading = false
                                            return
                                        }
                                        self.error = nil
                                        self.isLoading = false
                                        self.token = token
        })
    }
    
    private func setupText(with response: Token) {
        
        if response.body?.auth?.user != nil {
            self.user = response.body?.auth?.user
            self.didFinishFetch?()
        } else {
            self.noUsersFound?()
        }
        
    }
    
    
    
}


