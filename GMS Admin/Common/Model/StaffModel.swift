//
//  StaffModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class StaffModel: NSObject {
    
     var full_name: String?
     var phone_number: String?
     var email_id: String?
     var profile_pic: String?
     var status: String?
     var paguthi_name: String?
     var id: String?


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
        
          if let data = dict["id"] as? String {
             self.id = data
          }
        
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> StaffModel {
        let staffModel = StaffModel()
        staffModel.loadFromDictionary(dict)
        return staffModel
    }

}
