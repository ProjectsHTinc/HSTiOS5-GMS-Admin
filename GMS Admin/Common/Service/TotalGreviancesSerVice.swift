//
//  TotalGreviancesSerVice.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class TotalGreviancesSerVice: NSObject {

    public func callAPITotalGreivances(paguthi:String, onSuccess successCallback: ((_ totalGreviancesModel: TotalGreviancesModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPITotalGreivances(
          paguthi: paguthi, onSuccess: { (totalGreviancesModel) in
                successCallback?(totalGreviancesModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
