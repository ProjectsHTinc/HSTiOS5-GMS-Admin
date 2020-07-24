//
//  MeetingAllService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingAllService {
    
    public func callAPIMeetingAll(url: String, keyword: String, constituency_id:String, offset:String, rowcount:String, onSuccess successCallback: ((_ meetingAllModel: [MeetingAllModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIMeetingAll(
            url: url, keyword: keyword, constituency_id: constituency_id,offset: offset,rowcount: rowcount, onSuccess: { (meetingAllModel) in
                successCallback?(meetingAllModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
