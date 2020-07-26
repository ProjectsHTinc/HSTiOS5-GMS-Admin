//
//  ChangePasswordService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ChangePasswordService: NSObject {

    public func callAPIChangePassword(user_id:String,new_password:String,old_password:String, onSuccess successCallback: ((_ changePasswordModel: ChangePasswordModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIChangePassword(
            user_id: user_id,new_password: new_password,old_password: old_password, onSuccess: { (changePasswordModel) in
                successCallback?(changePasswordModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
