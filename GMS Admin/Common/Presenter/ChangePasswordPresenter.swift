//
//  ChangePasswordPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ChangePasswordData {
    let status: String
    let msg: String
}

protocol ChangePasswordView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setChangePassword(msg:String,status:String)
    func setEmpty(errorMessage:String)
}


class ChangePasswordPresenter: NSObject {
    
    private let changePasswordService:ChangePasswordService
    weak private var changePasswordView : ChangePasswordView?

    init(changePasswordService:ChangePasswordService) {
        self.changePasswordService = changePasswordService
    }

    func attachView(view:ChangePasswordView) {
         changePasswordView = view
    }

    func detachViewClientUrl() {
        changePasswordView = nil
    }
    
    func getChangePassword(user_id:String,new_password:String,old_password:String) {
        self.changePasswordView?.startLoading()
        changePasswordService.callAPIChangePassword(
            user_id: user_id,new_password: new_password,old_password: old_password, onSuccess: { (profUpdate) in
                self.changePasswordView?.finishLoading()
                self.changePasswordView?.setChangePassword(msg:profUpdate.msg!,status: profUpdate.status!)
            },
            onFailure: { (errorMessage) in
                self.changePasswordView?.setEmpty(errorMessage: errorMessage)
                self.changePasswordView?.finishLoading()

            }
        )
    }

}
