//
//  MeetingAllDetailService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingAllDetailService: NSObject {
    
    public func callAPIMeetingAllDetail(meeting_id : String, onSuccess successCallback: ((_ meetingAllDetailModel: [MeetingAllDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIMeetingAllDetail(
            meeting_id: meeting_id, onSuccess: { (meetingAllDetailModel) in
                successCallback?(meetingAllDetailModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
