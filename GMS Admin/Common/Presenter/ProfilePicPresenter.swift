//
//  ProfilePicPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ProfilePicData {
    let status: String
    let msg: String
}

protocol ProfilePicView: NSObjectProtocol {
    func startLoadingPic()
    func finishLoadingPic()
    func setProfilePic(msg:String,status:String)
    func setEmptyPic(errorMessage:String)
}

class ProfilePicPresenter: NSObject {
    
     private let profilePicUploadService:ProfilePicUploadService
     weak private var profilePicView : ProfilePicView?

     init(profilePicUploadService:ProfilePicUploadService) {
         self.profilePicUploadService = profilePicUploadService
     }

     func attachView(view:ProfilePicView) {
          profilePicView = view
     }

     func detachViewClientUrl() {
         profilePicView = nil
     }
     
     func getProfilePic(user_pic:String) {
         self.profilePicView?.startLoadingPic()
         profilePicUploadService.callAPIUserProfilePicUpdate(
             user_pic: user_pic, onSuccess: { (profUpdate) in
                 self.profilePicView?.finishLoadingPic()
                 self.profilePicView?.setProfilePic(msg:profUpdate.msg!,status: profUpdate.status!)
             },
             onFailure: { (errorMessage) in
                 self.profilePicView?.setEmptyPic(errorMessage: errorMessage)
                 self.profilePicView?.finishLoadingPic()

             }
         )
     }

}
