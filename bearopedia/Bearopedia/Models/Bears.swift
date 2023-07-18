//
//  Bears.swift
//  EvaGoetzke
//
//  Created by Eva Goetzke on 25/02/2022.
//

import Foundation

class Bears {
    // class data
    var data : [String: [Species]]
    
    //class init
    init(xmlFileName : String) {
        // make a XMLBearsParser
        let parser = XMLBearsParser(fileName: xmlFileName)
        
        //parsing
        parser.parsing()
        
        //set data with what comes from parsing
        self.data = parser.bears
    }
    
    //class methods
}
