//
//  Person.swift
//  PersonData
//
//  Created by Eva Goetzke on 11/02/2022.
//

import Foundation

class Bear {
    
    // attributes
    var name    :String
    var address :String
    var phone   :String
    var email   :String
    var image   :String
    
    //init-s
    init() {
        self.name = "John Doe"
        self.address = "no adress"
        self.phone = "none"
        self.email = "none"
        self.image = "none"
    }
    
    init(name:String, address:String, phone:String, email:String, image:String) {
        self.name = name
        self.address = address
        self.phone = phone
        self.email = email
        self.image = image
    }
    
    //methods if any
    
    
}
