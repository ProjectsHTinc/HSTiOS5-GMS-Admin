//
//  ReportGrievanceListModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 03/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//
import UIKit

class ReportGrievanceListModel: NSObject {
    
    var id: String?
    var door_no: String?
    var petition_enquiry_no : String?
    var grievance_date : String?
    var status : String?
    var full_name : String?
    var mobile_no : String?
    var created_by : String?
    var grievance_name : String?
    var grievance_type : String?
    var address : String?
    var father_husband_name : String?
    var office_name : String?
    var pin_code : String?
    var dob : String?

    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["door_no"] as? String {
            self.door_no = data
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
    class func build(_ dict: [String: AnyObject]) -> ReportGrievanceListModel {
        let reportModel = ReportGrievanceListModel()
        reportModel.loadFromDictionary(dict)
        return reportModel
    }

}
