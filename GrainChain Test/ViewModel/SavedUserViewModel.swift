//
//  SavedUserViewModel.swift
//  GrainChain Test
//
//  Created by Tecnocen on 3/7/19.
//  Copyright © 2019 Ana. All rights reserved.

import Foundation
import Alamofire
import RealmSwift
import Realm

class SavedUserViewModel {
    
    var user: Results<User>?
    var selectedUser: User? {
        didSet { }
    }
    
    //var users: User?
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var didFinishFetch: (() -> ())?
    var didFinishSaving: (() -> ())?
    var savingError: (() -> ())?
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var noUsersFound: (() -> ())?
    
    // MARK: - Constructor
    init(){
    }
    
    //MARK: REALM
    func saveNameUser(user : User) {
        let realm = try! Realm()
        realm.beginWrite()
        if let _ = realm.object(ofType: User.self, forPrimaryKey: user.name) {
            // Object exists already.
            realm.cancelWrite()
            //print("Already saved name with id:/\(user.name)")
            print("Already saved coupon with id: " + (user.name!))
            self.didFinishSaving?()
            return
        }
        realm.add(user)
        try! realm.commitWrite()
        self.didFinishSaving?()
    }
    
    func loadUser(){
        let realm = try! Realm()
        user = realm.objects(User.self)
        if(((user?.count)!) > 0){
            self.selectedUser = user?[0]
        }
    }
    
    
    
    
    
}

