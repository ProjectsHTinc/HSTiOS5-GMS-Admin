//
//  LoginModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 27/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MobileLoginModel {
    
    var msg : String?
    var status : String?
    var user_id: String?
    var user_role: String?
    var constituency_id: String?
    var pugathi_id: String?
    var full_name: String?
    var phone_number: String?
    var email_id: String?
    var gender: String?
    var address: String?
    var picture_url: String?
    var statusData: String?
    var last_login: String?
    var login_count: String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["msg"] as? String {
            self.msg = data
        }
        
        if let data = dict["status"] as? String {
            self.status = data
        }
        
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
        
        if let data = dict["address"] as? String {
            self.address = data
        }
        
        if let data = dict["picture_url"] as? String {
            self.picture_url = data
        }
        
        if let data = dict["status"] as? String {
            self.statusData = data
        }
        
        if let data = dict["last_login"] as? String {
            self.last_login = data
        }
        
        if let data = dict["login_count"] as? String {
            self.login_count = data
        }
        
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> MobileLoginModel {
        let loginModel = MobileLoginModel()
        loginModel.loadFromDictionary(dict)
        return loginModel
    }

}
