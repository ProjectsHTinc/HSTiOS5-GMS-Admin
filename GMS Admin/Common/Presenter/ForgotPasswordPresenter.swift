//
//  ForgotPasswordPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ForgotPasswordData {
    let status: String
    let msg: String

}
protocol ForgotPasswordView : NSObjectProtocol {

    func startLoading()
    func finishLoading()
    func setStatus(status:String,msg:String)
    func setEmpty(errorMessage:String)
}

class ForgotPasswordPresenter {
    
      private let forgotPasswordService:ForgotPasswordService
      weak private var forgotPasswordView : ForgotPasswordView?

     init(forgotPasswordService:ForgotPasswordService) {
        self.forgotPasswordService = forgotPasswordService
     }

     func attachView(view:ForgotPasswordView) {
         forgotPasswordView = view
     }

    func detachViewClientUrl() {
        forgotPasswordView = nil
    }
    
    func getFpStatus(user_name:String) {
        self.forgotPasswordView?.startLoading()
        forgotPasswordService.callAPIFp(
            user_name: user_name, onSuccess: { (fp) in
                self.forgotPasswordView?.setStatus(status: fp.status!,msg:fp.msg!)
                self.forgotPasswordView?.finishLoading()
            },
            onFailure: { (errorMessage) in
                self.forgotPasswordView?.setEmpty(errorMessage: errorMessage)
                self.forgotPasswordView?.finishLoading()
            }
        )
    }

}
