//
//  MobileLoginService.swift
//  GMS Admin
//
//  Created by HappysanziMac on 12/08/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class MobileLoginService {
    
    public func callAPIMobileLogin(user_name:String,dynamic_db:String, onSuccess successCallback: ((_ login: MobileLoginModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIMobileLogin(
            user_name: user_name,dynamic_db:dynamic_db, onSuccess: { (loginData) in
                successCallback?(loginData)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
