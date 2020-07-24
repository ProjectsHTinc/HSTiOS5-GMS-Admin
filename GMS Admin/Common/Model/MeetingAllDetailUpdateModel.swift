//
//  MeetingAllDetailUpdateModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingAllDetailUpdateModel: NSObject {
    
     var msg: String?
     var status: String?


     // MARK: Instance Method
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
    class func build(_ dict: [String: AnyObject]) -> MeetingAllDetailUpdateModel {
        let meetingAllDetailUpdateModel = MeetingAllDetailUpdateModel()
        meetingAllDetailUpdateModel.loadFromDictionary(dict)
        return meetingAllDetailUpdateModel
    }

}
