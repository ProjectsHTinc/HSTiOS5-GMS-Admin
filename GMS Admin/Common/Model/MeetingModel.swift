//
//  MeetingModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingModel: NSObject {
    
     var id: String?
     var constituent_id: String?
     var created_at : String?
     var meeting_date : String?
     var meeting_detail : String?
     var meeting_status : String?
     var meeting_title : String?


     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
          if let data = dict["id"] as? String {
             self.id = data
          }
        
          if let data = dict["constituent_id"] as? String {
             self.constituent_id = data
          }
        
          if let data = dict["created_at"] as? String {
             self.created_at = data
          }
        
          if let data = dict["meeting_date"] as? String {
             self.meeting_date = data
          }
        
         if let data = dict["meeting_detail"] as? String {
            self.meeting_detail = data
         }
      
         if let data = dict["meeting_status"] as? String {
             self.meeting_status = data
         }
        
        if let data = dict["meeting_title"] as? String {
            self.meeting_title = data
        }
      
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> MeetingModel {
        let meetingModel = MeetingModel()
        meetingModel.loadFromDictionary(dict)
        return meetingModel
    }

}
