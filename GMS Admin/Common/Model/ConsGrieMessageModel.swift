//
//  ConsModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 21/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConsModel: NSObject {
    
     var id: String?
     var sms_text: String?
     var created_at : String?
     var created_by : String?


     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
          if let data = dict["id"] as? String {
             self.id = data
          }
        
          if let data = dict["sms_text"] as? String {
             self.sms_text = data
          }
        
          if let data = dict["created_at"] as? String {
             self.created_at = data
          }
        
         if let data = dict["created_by"] as? String {
            self.created_by = data
         }

    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ConsModel {
        let consModel = ConsModel()
        consModel.loadFromDictionary(dict)
        return consModel
    }

}
