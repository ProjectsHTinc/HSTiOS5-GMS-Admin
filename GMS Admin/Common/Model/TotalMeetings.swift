//
//  TotalMeetings.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class TotalMeetings: NSObject {
    
    var total_meeting: String?
    var request_count_percentage: String?
    var request_count : String?
    var complete_count: String?
    var complete_count_percentage : String?

    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["total_meeting"] as? String?
 {
            self.total_meeting = data
        }
        if let data = dict["request_count_percentage"] as? String?
 {
            self.request_count_percentage = data
        }
        if let data = dict["request_count"] as? String?
 {
            self.request_count = data
        }
        if let data = dict["complete_count"] as? String?
 {
            self.complete_count = data
        }
        if let data = dict["complete_count_percentage"] as? String?
 {
            self.complete_count_percentage = data
        }

    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> TotalMeetings {
        let totalMeetings = TotalMeetings()
        totalMeetings.loadFromDictionary(dict)
        return totalMeetings
    }

}
