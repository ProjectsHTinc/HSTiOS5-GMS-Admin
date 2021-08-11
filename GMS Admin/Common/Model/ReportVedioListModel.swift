//
//  ReportVedioListModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation

class ReportVideoListModel: NSObject {
    
    var email_id: String?
    var full_name: String?
    var dob : String?
    var mobile_no : String?
    var door_no : String?
    var address : String?
    var pin_code : String?
    var father_husband_name : String?
    var created_at : String?


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
        if let data = dict["created_at"] as? String {
            self.created_at = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ReportVideoListModel {
        let reportBirthdayModel = ReportVideoListModel()
        reportBirthdayModel.loadFromDictionary(dict)
        return reportBirthdayModel
    }

}
