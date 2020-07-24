//
//  ReportBirthDayService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ReportBirthDayService: NSObject {

    public func callAPIReportBirthday(url:String, select_month : String, keyword: String, offset:String, rowcount:String, onSuccess successCallback: ((_ reportBirthdayModel: [ReportBirthdayModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIReportBirthday(
            url: url, select_month: select_month, keyword: keyword, offset: offset, rowcount: rowcount, onSuccess: { (reportBirthdayModel) in
                successCallback?(reportBirthdayModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
