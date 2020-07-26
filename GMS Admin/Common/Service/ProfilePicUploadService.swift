//
//  ProfilePicUploadService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ProfilePicUploadService: NSObject {
    
    public func callAPIUserProfilePicUpdate(user_pic:String, onSuccess successCallback: ((_ userProfilePicModel: UserProfilePicModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIUserProfilePicUpdate(
            user_pic: user_pic, onSuccess: { (userProfilePicModel) in
                successCallback?(userProfilePicModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
