//
//  ClientUrlService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ClientUrlService {
    
      public func callAPIGetClientUrl(select_ID:String, onSuccess successCallback: ((_ client_Url: [ClientUrlModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPIGetClientUrl(
              select_ID: select_ID, onSuccess: { (client_Url) in
                  successCallback?(client_Url)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }

}
