//
//  ConstituentGreivancesModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 20/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentGreivancesModel {
    
    var paguthi_name: String?
    var seeker_info: String?
    var grievance_name : String?
    var sub_category_name : String?
    var grievance_type : String?
    var petition_enquiry_no : String?
    var status : String?
    var created_at : String?
    var updated_by : String?
    var constituent_id : String?
    var grievance_type_id : String?
    var reference_note : String?
    var description : String?
    var id : String?
    var sub_category_id : String?
    var seeker_type_id : String?
    var enquiry_status : String?
    var created_by : String?
    var repeated_status : String?
    var paguthi_id : String?
    var grievance_date : String?
    var updated_at : String?
    var full_name : String?


    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["paguthi_name"] as? String {
            self.paguthi_name = data
        }
        if let data = dict["seeker_info"] as? String {
            self.seeker_info = data
        }
        if let data = dict["grievance_name"] as? String {
            self.grievance_name = data
        }
        if let data = dict["sub_category_name"] as? String {
            self.sub_category_name = data
        }
        if let data = dict["grievance_type"] as? String {
            self.grievance_type = data
        }
        if let data = dict["petition_enquiry_no"] as? String {
          self.petition_enquiry_no = data
        }
        if let data = dict["status"] as? String {
          self.status = data
        }
        if let data = dict["created_at"] as? String {
          self.created_at = data
        }
        if let data = dict["updated_by"] as? String {
          self.updated_by = data
        }
        if let data = dict["constituent_id"] as? String {
          self.constituent_id = data
        }
        if let data = dict["grievance_type_id"] as? String {
          self.grievance_type_id = data
        }
        if let data = dict["reference_note"] as? String {
          self.reference_note = data
        }
        if let data = dict["description"] as? String {
          self.description = data
        }
        if let data = dict["id"] as? String {
          self.id = data
        }
        if let data = dict["sub_category_id"] as? String {
          self.sub_category_id = data
        }
        if let data = dict["seeker_type_id"] as? String {
          self.seeker_type_id = data
        }
        if let data = dict["enquiry_status"] as? String {
          self.enquiry_status = data
        }
        if let data = dict["created_by"] as? String {
          self.created_by = data
        }
        if let data = dict["repeated_status"] as? String {
          self.repeated_status = data
        }
        if let data = dict["paguthi_id"] as? String {
          self.paguthi_id = data
        }
        if let data = dict["grievance_date"] as? String {
          self.grievance_date = data
        }
        if let data = dict["updated_at"] as? String {
          self.updated_at = data
        }
        if let data = dict["full_name"] as? String {
          self.full_name = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ConstituentGreivancesModel {
        let constituentGreivancesModel = ConstituentGreivancesModel()
        constituentGreivancesModel.loadFromDictionary(dict)
        return constituentGreivancesModel
    }

}
