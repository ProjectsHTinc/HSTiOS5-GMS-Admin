//
//  MeetingAll.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingAllModel: NSObject {
    
     var id: String?
     var full_name: String?
     var paguthi_name : String?
     var meeting_title : String?
     var meeting_date : String?
     var meeting_status : String?
     var created_by : String?


     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
          if let data = dict["id"] as? String {
             self.id = data
          }
        
          if let data = dict["full_name"] as? String {
             self.full_name = data
          }
        
          if let data = dict["paguthi_name"] as? String {
             self.paguthi_name = data
          }
        
         if let data = dict["meeting_title"] as? String {
            self.meeting_title = data
         }
        
         if let data = dict["meeting_date"] as? String {
            self.meeting_date = data
         }
        
         if let data = dict["meeting_status"] as? String {
            self.meeting_status = data
         }
        
         if let data = dict["created_by"] as? String {
            self.created_by = data
         }

    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> MeetingAllModel {
        let meetingAllModel = MeetingAllModel()
        meetingAllModel.loadFromDictionary(dict)
        return meetingAllModel
    }

}
