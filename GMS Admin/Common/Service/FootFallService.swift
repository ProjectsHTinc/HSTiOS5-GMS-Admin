//
//  FootFallService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class FootFallService : NSObject {

    public func callAPIFootfall(paguthi:String,from_date:String,to_date:String, dynamic_db:String,onSuccess successCallback: ((_ totalGreviancesModel: FootFallModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIFootfall(
            dynamic_db:dynamic_db, paguthi: paguthi,from_date:from_date,to_date: to_date,onSuccess: { (footFallModel) in
                successCallback?(footFallModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
