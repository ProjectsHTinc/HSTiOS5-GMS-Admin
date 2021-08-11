//
//  ProfileUpdateService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ProfileUpdateService: NSObject {
    
    public func callAPIUserProfileUpdate(user_id:String,name:String,address:String,phone:String,email:String,dynamic_db:String,gender:String, onSuccess successCallback: ((_ userProfileUpdateModel: UserProfileUpdateModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIUserProfileUpdate(
            dynamic_db:dynamic_db, user_id: user_id,name:name,address:address,phone:phone,email:email,gender:gender, onSuccess: { (userProfileUpdateModel) in
                successCallback?(userProfileUpdateModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
