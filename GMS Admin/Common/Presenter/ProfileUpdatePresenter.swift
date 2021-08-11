//
//  ProfileUpdatePresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ProfileUpdateData {
    let status: String
    let msg: String
}

protocol ProfileUpdatesView: NSObjectProtocol {
    func startLoadingUpdate()
    func finishLoadingUpdate()
    func setProfileUpdate(msg:String,status:String)
    func setEmptyUpdate(errorMessage:String)
}

class ProfileUpdatePresenter: NSObject {
    
    private let profileUpdateService:ProfileUpdateService
    weak private var profileUpdatesView : ProfileUpdatesView?

    init(profileUpdateService:ProfileUpdateService) {
        self.profileUpdateService = profileUpdateService
    }

    func attachView(view:ProfileUpdatesView) {
         profileUpdatesView = view
    }

    func detachViewClientUrl() {
        profileUpdatesView = nil
    }
    
    func getProfileUpdate(user_id:String,name:String,address:String,phone:String,email:String,gender:String,dynamic_db:String) {
        self.profileUpdatesView?.startLoadingUpdate()
        profileUpdateService.callAPIUserProfileUpdate(
            user_id: user_id, name: name,address: address, phone: phone, email: email, dynamic_db:dynamic_db, gender: gender, onSuccess: { (profUpdate) in
                self.profileUpdatesView?.finishLoadingUpdate()
                self.profileUpdatesView?.setProfileUpdate(msg:profUpdate.msg!,status: profUpdate.status!)
            },
            onFailure: { (errorMessage) in
                self.profileUpdatesView?.setEmptyUpdate(errorMessage: errorMessage)
                self.profileUpdatesView?.finishLoadingUpdate()

            }
        )
    }

}
