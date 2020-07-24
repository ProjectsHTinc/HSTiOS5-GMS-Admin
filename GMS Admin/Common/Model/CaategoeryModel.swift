//
//  CaategoeryModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class CaategoeryModel: NSObject {

    var id: String?
    var seeker_id: String?
    var grievance_name : String?
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
        if let data = dict["seeker_id"] as? String {
            self.seeker_id = data
        }
        if let data = dict["grievance_name"] as? String {
            self.grievance_name = data
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
    class func build(_ dict: [String: AnyObject]) -> CaategoeryModel {
        let caategoeryModel = CaategoeryModel()
        caategoeryModel.loadFromDictionary(dict)
        return caategoeryModel
    }
}
