//
//  OfficeModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 29/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class OfficeModel {
    
    var id: String?
    var office_name : String?
    var office_short_form : String?
    var status : String?
    var paguthi_id : String?
    var updated_at : String?
    var updated_by : String?

    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["office_name"] as? String {
            self.office_name = data
        }
        if let data = dict["office_short_form"] as? String {
            self.office_short_form = data
        }
        if let data = dict["status"] as? String {
            self.status = data
        }
        if let data = dict["paguthi_id"] as? String {
            self.paguthi_id = data
        }
       
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> OfficeModel {
        let officeModel = OfficeModel()
        officeModel.loadFromDictionary(dict)
        return officeModel
    }

}
