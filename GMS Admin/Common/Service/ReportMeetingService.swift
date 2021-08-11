//
//  ReportMeetingService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ReportMeetingService: NSObject {
    
    public func callAPIReportMeeting(url: String, dynamic_db:String,keyword: String, from_date:String, to_date:String, offset:String, rowcount:String, onSuccess successCallback: ((_ meetingAllModel: [MeetingAllModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIReportMeeting(
            dynamic_db:dynamic_db, url: url, keyword: keyword, from_date: from_date, to_date: to_date,offset: offset,rowcount: rowcount, onSuccess: { (meetingAllModel) in
                successCallback?(meetingAllModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
