//
//  MeetingService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingService {
    
    public func callAPIMeeting(constituency_id:String,offset:String,rowcount:String, onSuccess successCallback: ((_ meeting: [MeetingModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIMeeting(
          constituency_id: constituency_id,offset: offset,rowcount: rowcount, onSuccess: { (meeting) in
                successCallback?(meeting)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
