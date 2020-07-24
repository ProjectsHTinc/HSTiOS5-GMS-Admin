//
//  ReportStaffModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ReportStaffModel: NSObject {

    var id: String?
    var full_name: String?
    var total : String?
    var active : String?
    var inactive : String?


    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["full_name"] as? String {
            self.full_name = data
        }
        if let data = dict["total"] as? String {
            self.total = data
        }
        if let data = dict["active"] as? String {
            self.active = data
        }
        if let data = dict["inactive"] as? String {
            self.inactive = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ReportStaffModel {
        let reportStaffModel = ReportStaffModel()
        reportStaffModel.loadFromDictionary(dict)
        return reportStaffModel
    }
}
