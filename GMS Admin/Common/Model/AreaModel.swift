//
//  AreaModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 08/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class AreaModel {
    
    var id: String?
    var constituency_id: String?
    var paguthi_name : String?
    var paguthi_short_name : String?
    var status : String?
    var created_at : String?
    var created_by : String?
    var updated_at : String?
    var updated_by : String?

    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["constituency_id"] as? String {
            self.constituency_id = data
        }
        if let data = dict["paguthi_name"] as? String {
            self.paguthi_name = data
        }
        if let data = dict["paguthi_short_name"] as? String {
            self.paguthi_short_name = data
        }
        if let data = dict["status"] as? String {
            self.status = data
        }
        if let data = dict["created_at"] as? String {
            self.created_at = data
        }
        if let data = dict["created_by"] as? String {
            self.created_by = data
        }
        if let data = dict["updated_at"] as? String {
            self.updated_at = data
        }
        if let data = dict["updated_by"] as? String {
            self.updated_by = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> AreaModel {
        let areaModel = AreaModel()
        areaModel.loadFromDictionary(dict)
        return areaModel
    }

}
