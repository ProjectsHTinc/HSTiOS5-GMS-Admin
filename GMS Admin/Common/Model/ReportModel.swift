//
//  ReportModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ReportModel: NSObject {
    
    var id: String?
    var paguthi_name: String?
    var petition_enquiry_no : String?
    var grievance_date : String?
    var status : String?
    var full_name : String?
    var mobile_no : String?
    var created_by : String?
    var grievance_name : String?
    var role_name : String?
    var grievance_type : String?
    
    var address : String?
    var father_husband_name : String?
    var office_name : String?
    var pin_code : String?
    var dob : String?
    
    
    
//    "door_no" : "",
//    "mobile_no" : "",
//    "grievance_name" : "BUS ROUTES OF COIMBATORE TRANSPORT CORPORATION",
//    "address" : "23 VLB COLONY COIMBATORE",
//    "paguthi_name" : "SINGANALLUR",
//    "status" : "PENDING",
//    "father_husband_name" : "CHANDRASEKAR",
//    "role_name" : "ADMIN",
//    "created_by" : "SUPER ADMIN",
//    "office_name" : "SINGANALLUR OFFICE ONE",
//    "pin_code" : "",
//    "full_name" : "RAJAN C",
//    "grievance_date" : "2020-11-29",
//    "id" : "11",
//    "grievance_type" : "P",
//    "dob" : "0000-00-00",
//    "petition_enquiry_no" : "CBE 1PT10"

    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["paguthi_name"] as? String {
            self.paguthi_name = data
        }
        if let data = dict["petition_enquiry_no"] as? String {
            self.petition_enquiry_no = data
        }
        if let data = dict["grievance_date"] as? String {
            self.grievance_date = data
        }
        if let data = dict["status"] as? String {
            self.status = data
        }
        if let data = dict["full_name"] as? String {
          self.full_name = data
        }
        if let data = dict["mobile_no"] as? String {
          self.mobile_no = data
        }
        if let data = dict["created_by"] as? String {
          self.created_by = data
        }
        if let data = dict["grievance_name"] as? String {
          self.grievance_name = data
        }
        if let data = dict["role_name"] as? String {
          self.role_name = data
        }
        if let data = dict["grievance_type"] as? String {
          self.grievance_type = data
        }
        if let data = dict["address"] as? String {
          self.address = data
        }
        if let data = dict["father_husband_name"] as? String {
          self.father_husband_name = data
        }
        if let data = dict["office_name"] as? String {
          self.office_name = data
        }
        if let data = dict["pin_code"] as? String {
          self.pin_code = data
        }
        if let data = dict["dob"] as? String {
          self.dob = data
        }
    }
   
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ReportModel {
        let reportModel = ReportModel()
        reportModel.loadFromDictionary(dict)
        return reportModel
    }

}
