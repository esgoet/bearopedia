//
//  Species.swift
//  EvaGoetzke
//
//  Created by Eva Goetzke on 25/02/2022.
//

import Foundation

class Species {
    
    // attributes
    var commonName      :String
    var scientificName  :String
    var habitats        :[String]
    var diet            :String
    var funFact         :String
    var image           :String
    var url             :String
    var isFavorited     :Bool =  false
    var indexPath       :IndexPath = IndexPath()
    
    //init-s
    init() {
        self.commonName     = ""
        self.scientificName = ""       
        self.habitats       = [""]
        self.diet           = ""
        self.funFact        = ""
        self.image          = ""
        self.url            = ""
    }
    
    init(commonName:String, scientificName:String, habitats:[String], diet:String, funFact:String, image:String, url: String) {
        self.commonName = commonName
        self.scientificName = scientificName
        self.habitats = habitats
        self.diet = diet
        self.funFact = funFact
        self.image = image
        self.url = url
    }
    
    //methods if any
    
    
}

