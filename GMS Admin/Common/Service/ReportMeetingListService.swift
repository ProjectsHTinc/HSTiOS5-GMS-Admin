//
//  ReportMeetingListService.swift
//  GMS Admin
//
//  Created by HappysanziMac on 12/08/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation
import UIKit

class ReportMeetingListService: NSObject {

    public func callAPIReportMeetingList(url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String, onSuccess successCallback: ((_ caategoeryModel: [ReportMeetingListModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIReportMeetingList(
            dynamic_db:dynamic_db, url : url,From: From,from_date: from_date,to_date: to_date,status: status,paguthi: paguthi,offset: offset,rowcount: rowcount,category: category,sub_category: sub_category,keyword: keyword,office:office, onSuccess: { (caategoeryModel) in
                successCallback?(caategoeryModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
