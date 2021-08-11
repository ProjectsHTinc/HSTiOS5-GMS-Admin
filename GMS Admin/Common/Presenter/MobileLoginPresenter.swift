//
//  MobileLoginPresenter.swift
//  GMS Admin
//
//  Created by HappysanziMac on 02/08/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

struct MobileloginData {
    
    let user_id: String
    let user_role: String
    let constituency_id: String
    let pugathi_id: String
    let full_name: String
    let phone_number: String
    let email_id: String
    let gender: String
    let address: String
    let picture_url: String
    let statusData: String
    let last_login: String
    let login_count: String

}

protocol MobileLoginView : NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setLoginData(user_id:String,userImage:String,userName:String,userlocation:String)
    func setEmpty(errorMessage:String)
}

class MobileLoginPresenter {
    
      private let loginService:MobileLoginService
      weak private var loginView : MobileLoginView?

     init(loginService:MobileLoginService) {
        self.loginService = loginService
     }

     func attachView(view:MobileLoginView) {
         loginView = view
     }

    func detachViewClientUrl() {
        loginView = nil
    }
    
    func getLoginData(user_name:String,dynamic_db:String) {
        self.loginView?.startLoading()
        loginService.callAPIMobileLogin(
            user_name: user_name,dynamic_db:dynamic_db, onSuccess: { (login) in
                self.loginView?.finishLoading()
                self.loginView?.setLoginData(user_id: login.user_id!,userImage:login.picture_url!,userName: login.full_name!,userlocation: login.address!)
            },
            onFailure: { (errorMessage) in
                self.loginView?.setEmpty(errorMessage: errorMessage)
                self.loginView?.finishLoading()

            }
        )
    }

}
