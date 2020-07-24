//
//  AppVersionPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct appVersionData {
    let status: String
}
protocol AppVersionView : NSObjectProtocol {

    func startLoading()
    func finishLoading()
    func setAppversion(status:String)
    func setEmpty(errorMessage:String)
}

class AppVersionPresenter {

        private let appVersionService:AppVersionService
        weak private var appVersionView : AppVersionView?

       init(appVersionService:AppVersionService) {
          self.appVersionService = appVersionService
       }

       func attachView(view:AppVersionView) {
           appVersionView = view
       }

      func detachViewClientUrl() {
          appVersionView = nil
      }
      
      func getAppVersion(version_code:String) {
          self.appVersionView?.startLoading()
          appVersionService.callAPIAppversion(
              version_code: version_code, onSuccess: { (appversion) in
                  self.appVersionView?.setAppversion(status: appversion.status!)
                  self.appVersionView?.finishLoading()
              },
              onFailure: { (errorMessage) in
                  self.appVersionView?.setEmpty(errorMessage: errorMessage)
                  self.appVersionView?.finishLoading()
              }
          )
      }
}
