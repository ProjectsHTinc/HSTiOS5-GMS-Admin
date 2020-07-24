//
//  ForgotPasswordService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ForgotPasswordService {

      public func callAPIFp(user_name:String, onSuccess successCallback: ((_ Fp: ForgotPasswordModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPIFp(
            user_name: user_name, onSuccess: { (Fp) in
                  successCallback?(Fp)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }
}
