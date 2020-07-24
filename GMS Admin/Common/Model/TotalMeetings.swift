//
//  TotalMeetings.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class TotalMeetings: NSObject {
    
    var meeting_count: Int?
    var requested_count: Int?
    var completed_count : Int?


    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["meeting_count"] as? Int?
 {
            self.meeting_count = data
        }
        if let data = dict["requested_count"] as? Int?
 {
            self.requested_count = data
        }
        if let data = dict["completed_count"] as? Int?
 {
            self.completed_count = data
        }

    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> TotalMeetings {
        let totalMeetings = TotalMeetings()
        totalMeetings.loadFromDictionary(dict)
        return totalMeetings
    }

}
