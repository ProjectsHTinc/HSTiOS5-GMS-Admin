//
//  AppVersionService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class AppVersionService {

      public func callAPIAppversion(version_code:String, onSuccess successCallback: ((_ appversion: AppVersionModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPIAppversion(
            version_code: version_code, onSuccess: { (appversion) in
                  successCallback?(appversion)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }
}
