//
//  People.swift
//  PeopleInfoTable
//
//  Created by Eva Goetzke on 18/02/2022.
//

import Foundation

class People {
    // class data
    var peopleData : [Person]
    
    //class init
    init() {
        peopleData = [
            Person(name: "Mr Panda Bear", address: "The Jungle", phone: "01355-JUNGLE-2", email: "cutestpanda@bears.com", image: "pandabear.jpg"),
            Person(name: "Ms Polar Bear", address: "The Arctic", phone: "0394-ICE-332", email: "icequeen7@bears.com", image: "polarbear2.jpg"),
            Person(name: "Ms Panda Bear", address: "The Jungle", phone: "02355-JUNGLE-2", email: "ilikebamboo@bears.com", image: "pandabear2.jpg"),
            Person(name: "Mr Polar Bear", address: "The Arctic", phone: "0394-ICE-332", email: "iceking94@bears.com", image: "polarbear.jpg")
        ]
    }
    
    //class methods
    
    func getCount() -> Int{return peopleData.count}
    
    func getPerson(index: Int) -> Person{return peopleData[index]}
}
