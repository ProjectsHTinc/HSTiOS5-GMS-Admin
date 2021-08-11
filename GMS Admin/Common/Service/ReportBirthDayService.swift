//
//  ReportBirthDayService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ReportBirthDayService: NSObject {

    public func callAPIReportBirthday(url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String ,onSuccess successCallback: ((_ reportBirthdayModel: [ReportBirthdayModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIReportBirthday(
            url : url,From: From,from_date: from_date,to_date: to_date,status: status,paguthi: paguthi,offset: offset,rowcount: rowcount,category: category,sub_category: sub_category,keyword: keyword,dynamic_db:dynamic_db,office:office,onSuccess: { (reportBirthdayModel) in
                successCallback?(reportBirthdayModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
