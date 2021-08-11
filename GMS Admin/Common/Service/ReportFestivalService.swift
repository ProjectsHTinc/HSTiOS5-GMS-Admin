//
//  ReportFestivalService.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation

class ReportFestivalService: NSObject {

    public func callAPIReportFestival(dynamic_db:String ,onSuccess successCallback: ((_ paguthi: [ReportFestivalModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIReportFestival(
            dynamic_db:dynamic_db,onSuccess: { (paguthi) in
                successCallback?(paguthi)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
