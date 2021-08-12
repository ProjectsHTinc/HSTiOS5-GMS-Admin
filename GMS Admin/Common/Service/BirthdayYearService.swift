//
//  BirthdayYearService.swift
//  GMS Admin
//
//  Created by HappysanziMac on 12/08/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation
import UIKit

class BirthdayYearService: NSObject {

    public func callAPIBirthdayYear(dynamic_db:String,onSuccess successCallback: ((_ caategoeryModel: [BirthdayYearModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIBirthdayYear(
            dynamic_db:dynamic_db,onSuccess: { (caategoeryModel) in
                successCallback?(caategoeryModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
