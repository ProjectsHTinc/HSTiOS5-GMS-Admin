//
//  ForgotPasswordModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ForgotPasswordModel {

     var msg : String?
     var status : String?
    
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["msg"] as? String {
            self.msg = data
        }
        
        if let data = dict["status"] as? String {
            self.status = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ForgotPasswordModel {
        let forgotPasswordModel = ForgotPasswordModel()
        forgotPasswordModel.loadFromDictionary(dict)
        return forgotPasswordModel
    }
}
