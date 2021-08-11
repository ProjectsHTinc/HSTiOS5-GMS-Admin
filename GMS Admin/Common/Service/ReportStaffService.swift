//
//  ReportStaffService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ReportStaffService: NSObject {

    public func callAPIReportStaff(from_date:String, dynamic_db:String,to_date:String, onSuccess successCallback: ((_ reportStaffModel: [ReportStaffModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIReportStaff(
            dynamic_db:dynamic_db, from_date: from_date, to_date: to_date, onSuccess: { (reportStaffModel) in
                successCallback?(reportStaffModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
