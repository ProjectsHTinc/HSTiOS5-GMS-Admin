//
//  ReportMeetingModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 02/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class ReportMeetingListModel: NSObject {
    
    var id : String?
    var paguthi_name : String?
    var full_name : String?
    var mobile_no : String?
    var created_by : String?
    var door_no : String?
    var address : String?
    var father_husband_name : String?
    var office_name : String?
    var pin_code : String?
    var dob : String?
    var meeting_date : String?
    var meeting_status : String?

    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["paguthi_name"] as? String {
            self.paguthi_name = data
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
        if let data = dict["meeting_date"] as? String {
          self.meeting_date = data
        }
        if let data = dict["meeting_status"] as? String {
          self.meeting_status = data
        }
        if let data = dict["door_no"] as? String {
          self.door_no = data
        }
    }
   
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ReportMeetingListModel {
        let reportModel = ReportMeetingListModel()
        reportModel.loadFromDictionary(dict)
        return reportModel
    }

}
