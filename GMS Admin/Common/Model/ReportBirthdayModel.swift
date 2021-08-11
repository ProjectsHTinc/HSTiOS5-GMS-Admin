//
//  ReportBirthdayModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ReportBirthdayModel: NSObject {
    
    var email_id: String?
    var full_name: String?
    var dob : String?
    var mobile_no : String?
    var door_no : String?
    var address : String?
    var pin_code : String?
    var father_husband_name : String?
    var send_on : String?


    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["email_id"] as? String {
            self.email_id = data
        }
        if let data = dict["full_name"] as? String {
            self.full_name = data
        }
        if let data = dict["dob"] as? String {
            self.dob = data
        }
        if let data = dict["mobile_no"] as? String {
            self.mobile_no = data
        }
        if let data = dict["door_no"] as? String {
            self.door_no = data
        }
        if let data = dict["address"] as? String {
            self.address = data
        }
        if let data = dict["pin_code"] as? String {
            self.pin_code = data
        }
        if let data = dict["father_husband_name"] as? String {
            self.father_husband_name = data
        }
        if let data = dict["send_on"] as? String {
            self.send_on = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ReportBirthdayModel {
        let reportBirthdayModel = ReportBirthdayModel()
        reportBirthdayModel.loadFromDictionary(dict)
        return reportBirthdayModel
    }

}
