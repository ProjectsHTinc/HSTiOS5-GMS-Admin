//
//  GreivancesAllService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class GreivancesAllService: NSObject {
    
    public func callAPIGreivancesAll(url : String, keyword: String, dynamic_db:String,paguthi:String, offset:String, rowcount:String, grievance_type: String, onSuccess successCallback: ((_ constituentGreivancesModel: [ConstituentGreivancesModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIGreivancesAll(
            dynamic_db:dynamic_db, url: url, keyword: keyword, paguthi: paguthi, grievance_type: grievance_type, offset: offset, rowcount: rowcount,onSuccess: { (constituentGreivancesModel) in
                successCallback?(constituentGreivancesModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
