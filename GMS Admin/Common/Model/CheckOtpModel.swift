//
//  CheckOtpModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 02/08/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit
import Foundation

class OTPModel {
    
    var user_count: Int?
    var id: String?
    var full_name: String?
    var father_husband_name: String?
    var dob: String?
    var profile_picture: String?
    var serial_no: String?


    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["user_count"] as? Int {
            self.user_count = data
        }
        
        if let data = dict["id"] as? String {
            self.id = data
        }
        
        if let data = dict["full_name"] as? String {
            self.full_name = data
        }
        
        if let data = dict["father_husband_name"] as? String {
            self.father_husband_name = data
        }
        
        if let data = dict["dob"] as? String {
            self.dob = data
        }
        
        if let data = dict["profile_picture"] as? String {
            self.profile_picture = data
        }
        
        if let data = dict["serial_no"] as? String {
            self.serial_no = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> OTPModel {
        let otp = OTPModel()
        otp.loadFromDictionary(dict)
        return otp
    }


}
