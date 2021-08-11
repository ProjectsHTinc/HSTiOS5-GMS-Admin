//
//  ReportFestivalModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 01/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation
import UIKit

class ReportFestivalModel {
    
    var id: String?
    var festival_name : String?
    var religion_id : String?
    var status : String?
   

    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["festival_name"] as? String {
            self.festival_name = data
        }
        if let data = dict["religion_id"] as? String {
            self.religion_id = data
        }
        if let data = dict["status"] as? String {
            self.status = data
        }
        
    }
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ReportFestivalModel {
        let reportFestivalModel = ReportFestivalModel()
        reportFestivalModel.loadFromDictionary(dict)
        return reportFestivalModel
    }
}
