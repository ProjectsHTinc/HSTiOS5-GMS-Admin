//
//  CheckConstituentModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 19/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class CheckConstituentModel {
    
    var consituency_code : String?
    var constituency_name : String?
    var contact_person: String?
    var email_id: String?
    var mobile: String?
    var party_name: String?
    var msg: String?
   
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["consituency_code"] as? String {
            self.consituency_code = data
        }
        
        if let data = dict["constituency_name"] as? String {
            self.constituency_name = data
        }
        
        if let data = dict["contact_person"] as? String {
            self.contact_person = data
        }
        
        if let data = dict["email_id"] as? String {
            self.email_id = data
        }
        
        if let data = dict["mobile"] as? String {
            self.mobile = data
        }
        
        if let data = dict["party_name"] as? String {
            self.party_name = data
        }
        if let data = dict["msg"] as? String {
            self.msg = data
        }
        
        
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> CheckConstituentModel {
        let checkConstituentModel = CheckConstituentModel()
        checkConstituentModel.loadFromDictionary(dict)
        return checkConstituentModel
    }

}
