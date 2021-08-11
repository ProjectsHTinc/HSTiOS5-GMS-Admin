//
//  SeekerNameModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 03/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation

class SeekerTypeModel: NSObject {

        var id: String?
        var seeker_info: String?
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
            if let data = dict["seeker_info"] as? String {
                self.seeker_info = data
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
    class func build(_ dict: [String: AnyObject]) -> SeekerTypeModel {
        let caategoeryModel = SeekerTypeModel()
        caategoeryModel.loadFromDictionary(dict)
        return caategoeryModel
    }
}
