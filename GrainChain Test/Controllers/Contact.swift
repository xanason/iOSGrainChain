//
//  Contact.swift
//  GrainChain Test
//
//  Created by Tecnocen on 3/6/19.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation
/*
struct Contact {
    let name : String
    let lastname : String
    let age : String
    let numberPhone : String
}*/

class Contact: NSObject {
    var name:String = ""
    var lastname:String = ""
    var age:String = ""
    var numberPhone: String = ""
    
    init(name:String,lastname:String,age:String,numberPhone:String) {
        self.name = name
        self.lastname = lastname
        self.age = age
        self.numberPhone = numberPhone
    }
    
    class func generateModelArray() -> [Contact]{
        var modelArray = [Contact]()
        
        modelArray.append(Contact(name:"Ana", lastname:"Anguiano", age:"23", numberPhone:"55 44 57 75 80"))
        modelArray.append(Contact(name:"Ruth", lastname:"Cruz", age:"26", numberPhone:"55 34 35 83 31"))
        modelArray.append(Contact(name:"Victor", lastname:"García", age:"23", numberPhone:"55 09 80 76 26"))
        modelArray.append(Contact(name:"Adriana", lastname:"Arroyo", age:"30", numberPhone:"55 66 70 90 08"))
        modelArray.append(Contact(name:"Karla", lastname:"Sanchez", age:"40", numberPhone:"55 34 35 83 31"))
        modelArray.append(Contact(name:"José", lastname:"Pérez", age:"35", numberPhone:"55 66 70 90 08"))
        modelArray.append(Contact(name:"Nahum", lastname:"Guzmán", age:"69", numberPhone:"55 09 80 76 26"))
        modelArray.append(Contact(name:"Aída", lastname:"Ortíz", age:"50", numberPhone:"55 44 57 75 80"))
        modelArray.append(Contact(name:"Carlos", lastname:"Loredo ", age:"15", numberPhone:"55 66 70 90 08"))
        modelArray.append(Contact(name:"Diego", lastname:"Ramírez", age:"24", numberPhone:"55 34 35 83 31"))
        
        return modelArray
    }
}
