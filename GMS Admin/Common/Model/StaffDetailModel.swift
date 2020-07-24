//
//  StaffDetailModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class StaffDetailModel: NSObject {
    
    var full_name: String?
    var phone_number: String?
    var email_id: String?
    var profile_pic: String?
    var status: String?
    var paguthi_name: String?
    var role_name: String?
    var id: String?
    var constituency_id: String?
    var pugathi_id: String?
    var role_id: String?
    var password: String?
    var gender: String?
    var address: String?
    var last_login: String?
    var verification_code: String?
    var login_count: String?
    var created_by: String?
    var created_at: String?
    var updated_by: String?
    var updated_at: String?


     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
          if let data = dict["full_name"] as? String {
             self.full_name = data
          }
        
          if let data = dict["phone_number"] as? String {
             self.phone_number = data
          }
        
          if let data = dict["email_id"] as? String {
             self.email_id = data
          }
        
          if let data = dict["profile_pic"] as? String {
              self.profile_pic = data
          }
        
          if let data = dict["status"] as? String {
             self.status = data
          }
        
          if let data = dict["paguthi_name"] as? String {
             self.paguthi_name = data
          }
        
          if let data = dict["role_name"] as? String {
             self.role_name = data
          }
        
          if let data = dict["paguthi_name"] as? String {
             self.paguthi_name = data
          }
        
          if let data = dict["id"] as? String {
             self.id = data
          }
        
          if let data = dict["constituency_id"] as? String {
             self.constituency_id = data
          }
        
          if let data = dict["pugathi_id"] as? String {
             self.pugathi_id = data
          }
        
          if let data = dict["role_id"] as? String {
             self.role_id = data
          }
        
          if let data = dict["password"] as? String {
             self.password = data
          }
        
         if let data = dict["gender"] as? String {
            self.gender = data
         }
        
         if let data = dict["address"] as? String {
            self.address = data
         }
        
         if let data = dict["last_login"] as? String {
            self.last_login = data
         }
        
         if let data = dict["verification_code"] as? String {
            self.verification_code = data
         }
        
         if let data = dict["login_count"] as? String {
            self.login_count = data
         }
        
         if let data = dict["created_by"] as? String {
            self.created_by = data
         }
        
         if let data = dict["created_at"] as? String {
            self.created_at = data
         }
        
         if let data = dict["updated_by"] as? String {
            self.created_at = data
         }
        
         if let data = dict["updated_at"] as? String {
            self.created_at = data
         }
        
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> StaffDetailModel {
        let staffDetailModel = StaffDetailModel()
        staffDetailModel.loadFromDictionary(dict)
        return staffDetailModel
    }

}
