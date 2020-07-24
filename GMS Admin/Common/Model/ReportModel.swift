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
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ReportModel {
        let reportModel = ReportModel()
        reportModel.loadFromDictionary(dict)
        return reportModel
    }

}
