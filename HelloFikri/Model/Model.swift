//
//  Model.swift
//  HelloFikri
//
//  Created by Fikri on 01/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding {
    var name: String
    
    init?(name: String) {
        self.name = name
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObject(forKey: "name") as! String
        self.init(name: name)
    }
    
    static let Dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = Dir.appendingPathComponent("items")
    
}

