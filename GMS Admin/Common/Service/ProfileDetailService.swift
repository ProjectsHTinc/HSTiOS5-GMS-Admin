//
//  ProfileDetailService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ProfileDetailService: NSObject {
    
    public func callAPIUserProfileDetails(user_id:String, dynamic_db:String,onSuccess successCallback: ((_ userProfileModel: UserProfileModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIUserProfileDetails(
            dynamic_db:dynamic_db, user_id: user_id, onSuccess: { (userProfileModel) in
                successCallback?(userProfileModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
