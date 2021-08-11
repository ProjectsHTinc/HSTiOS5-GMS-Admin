//
//  ReportGrievanceListService.swift
//  GMS Admin
//
//  Created by HappysanziMac on 03/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation


class ReportGrievanceListService: NSObject {
    
    public func callAPIReportGrievanceList(url : String,seeker_type_id: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String, onSuccess successCallback: ((_ reportModel: [ReportGrievanceListModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIReportGrievanceList(
            dynamic_db:dynamic_db, url:url,seeker_type_id: seeker_type_id,from_date: from_date,to_date: to_date,status: status,paguthi: paguthi,offset: offset,rowcount: rowcount,category: category,sub_category: sub_category,keyword: keyword,office:office ,onSuccess: { (reportModel) in
                successCallback?(reportModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
