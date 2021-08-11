//
//  ReportConstituentService.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation

import UIKit

class ReportConstituentListService: NSObject {

    public func callAPIReportConstituentList(url: String, whatsap: String, emailId: String, voterId: String, paguthi: String,offset:String,rowCount:String,dob: String, phoneNum: String, keyword: String,dynamic_db:String,office:String ,onSuccess successCallback: ((_ reportBirthdayModel: [ReportConstituentListModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIReportConstituentList(
            url : url,whatsap: whatsap,emailId: emailId,voterId: voterId,paguthi: paguthi,offset: offset,rowCount: rowCount,dob: phoneNum,phoneNum: dob,keyword:keyword,dynamic_db:dynamic_db,office:office,onSuccess: { (reportBirthdayModel) in
                successCallback?(reportBirthdayModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}

class ReportVideoListService: NSObject {

    public func callAPIReportVideoList(url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String ,onSuccess successCallback: ((_ reportBirthdayModel: [ReportVideoListModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIReportVideoList(
            url : url,From: From,from_date: from_date,to_date: to_date,status: status,paguthi: paguthi,offset: offset,rowcount: rowcount,category: category,sub_category: sub_category,keyword: keyword,dynamic_db:dynamic_db,office:office,onSuccess: { (reportBirthdayModel) in
                successCallback?(reportBirthdayModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
