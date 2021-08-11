//
//  ConstituentGreivancesMessageService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 21/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentGreivancesMessageService {
    
    public func callAPIConstituentGreivancesMeeting(grievance_id:String, dynamic_db:String,onSuccess successCallback: ((_ consGrieMessageModel: [ConsGrieMessageModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIConstituentGreivancesMeeting(
            dynamic_db:dynamic_db, grievance_id: grievance_id, onSuccess: { (consGrieMessageModel) in
                successCallback?(consGrieMessageModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
