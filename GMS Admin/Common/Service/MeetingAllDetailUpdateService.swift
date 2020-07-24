//
//  MeetingAllDetailUpdateService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingAllDetailUpdateService: NSObject {
    
    public func callAPIMeetingAllDetailUpdate(meeting_id : String, user_id : String, status : String, onSuccess successCallback: ((_ meetingAllDetailUpdateModel: MeetingAllDetailUpdateModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIMeetingAllDetailUpdate(
            meeting_id: meeting_id, user_id: user_id, status: status, onSuccess: { (meetingAllDetailUpdateModel) in
                successCallback?(meetingAllDetailUpdateModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
