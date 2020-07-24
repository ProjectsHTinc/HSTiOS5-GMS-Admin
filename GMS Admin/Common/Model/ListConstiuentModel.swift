//
//  ListConstiuentModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 13/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ListConstiuentModel {
    
    var id: String?
    var full_name: String?
    var mobile_no : String?
    var serial_no : String?
    var profile_pic : String?
    var constituent_count : Int?

    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["full_name"] as? String {
            self.full_name = data
        }
        if let data = dict["mobile_no"] as? String {
            self.mobile_no = data
        }
        if let data = dict["serial_no"] as? String {
            self.serial_no = data
        }
        if let data = dict["profile_pic"] as? String {
            self.profile_pic = data
        }
        if let data = dict["constituent_count"] as? Int {
            self.constituent_count = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ListConstiuentModel {
        let listConstiuentModel = ListConstiuentModel()
        listConstiuentModel.loadFromDictionary(dict)
        return listConstiuentModel
    }

}
