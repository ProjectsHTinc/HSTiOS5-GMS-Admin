//
//  UserProfileModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class UserProfileModel: NSObject {
    
    var user_id: String?
    var user_role: String?
    var constituency_id : String?
    var pugathi_id : String?
    var full_name : String?
    var phone_number : String?
    var email_id : String?
    var gender : String?
    var address : String?
    var picture_url : String?


    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["user_id"] as? String {
            self.user_id = data
        }
        if let data = dict["user_role"] as? String {
            self.user_role = data
        }
        if let data = dict["constituency_id"] as? String {
            self.constituency_id = data
        }
        if let data = dict["pugathi_id"] as? String {
            self.pugathi_id = data
        }
        if let data = dict["full_name"] as? String {
            self.full_name = data
        }
        if let data = dict["phone_number"] as? String {
            self.phone_number = data
        }
        if let data = dict["email_id"] as? String {
            self.email_id = data
        }
        if let data = dict["gender"] as? String {
            self.gender = data
        }
        if let data = dict["picture_url"] as? String {
            self.picture_url = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> UserProfileModel {
        let userProfileModel = UserProfileModel()
        userProfileModel.loadFromDictionary(dict)
        return userProfileModel
    }

}
