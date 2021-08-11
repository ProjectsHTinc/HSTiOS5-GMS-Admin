//
//  ReportStafffListModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//
import Foundation

class ReportStaffListModel: NSObject {
    
    var full_name: String?
    var id: String?
    var total_broadcast : String?
    var total_cons : String?
    var total_g : String?
    var total_v : String?


    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["full_name"] as? String {
            self.full_name = data
        }
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["total_broadcast"] as? String {
            self.total_broadcast = data
        }
        if let data = dict["total_cons"] as? String {
            self.total_cons = data
        }
        if let data = dict["total_g"] as? String {
            self.total_g = data
        }
        if let data = dict["total_v"] as? String {
            self.total_v = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ReportStaffListModel {
        let reportBirthdayModel = ReportStaffListModel()
        reportBirthdayModel.loadFromDictionary(dict)
        return reportBirthdayModel
    }

}
