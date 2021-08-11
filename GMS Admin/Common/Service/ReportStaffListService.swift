//
//  ReportVedioListService.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation

class ReportStaffListService: NSObject {

    public func callAPIReportStaffList(url:String,from_date: String,to_date: String,dynamic_db:String,onSuccess successCallback: ((_ reportBirthdayModel: [ReportStaffListModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIReportStaffList(
            url:url,from_date: from_date,to_date: to_date,dynamic_db:dynamic_db,onSuccess: { (reportBirthdayModel) in
                successCallback?(reportBirthdayModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
