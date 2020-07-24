//
//  TotalMeetingService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class TotalMeetingService: NSObject {

    public func callAPITotalMeetings(paguthi:String, onSuccess successCallback: ((_ totalMeetings: TotalMeetings) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPITotalMeetings(
          paguthi: paguthi, onSuccess: { (totalMeetings) in
                successCallback?(totalMeetings)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
