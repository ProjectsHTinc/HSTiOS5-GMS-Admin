//
//  ConstituencyModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 27/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituencyModel {
    
    var id: Int?
    var party_id: Int?
    var constituency_name : String?
    var constituency_id : Int?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["id"] as? Int {
            self.id = data
        }
        if let data = dict["party_id"] as? Int {
            self.party_id = data
        }
        if let data = dict["constituency_name"] as? String {
            self.constituency_name = data
        }
        if let data = dict["constituency_id"] as? Int {
            self.constituency_id = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ConstituencyModel {
        let constituency = ConstituencyModel()
        constituency.loadFromDictionary(dict)
        return constituency
    }

}
