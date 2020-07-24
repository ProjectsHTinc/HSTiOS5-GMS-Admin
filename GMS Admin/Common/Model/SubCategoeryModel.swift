//
//  SubCategoeryModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class SubCategoeryModel: NSObject {
    
    var id: String?
    var grievance_id: String?
    var sub_category_name : String?
    var status : String?
    var created_by : String?
    var created_at : String?
    var updated_by : String?
    var updated_at : String?



    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["grievance_id"] as? String {
            self.grievance_id = data
        }
        if let data = dict["sub_category_name"] as? String {
            self.sub_category_name = data
        }
        if let data = dict["created_by"] as? String {
            self.created_by = data
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
        if let data = dict["updated_at"] as? String {
          self.updated_at = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> SubCategoeryModel {
        let subCategoeryModel = SubCategoeryModel()
        subCategoeryModel.loadFromDictionary(dict)
        return subCategoeryModel
    }

}
