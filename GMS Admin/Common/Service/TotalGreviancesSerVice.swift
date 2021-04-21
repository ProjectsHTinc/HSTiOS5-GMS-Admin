//
//  TotalGreviancesSerVice.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class TotalGreviancesSerVice: NSObject {

    public func callAPITotalGreivances(paguthi:String,from_date:String,to_date:String, onSuccess successCallback: ((_ totalGreviancesModel: TotalGreviancesModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPITotalGreivances(
            paguthi: paguthi,from_date:from_date,to_date:to_date, onSuccess: { (totalGreviancesModel) in
                successCallback?(totalGreviancesModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
