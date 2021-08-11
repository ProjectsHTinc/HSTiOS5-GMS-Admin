//
//  CheckConstituentService.swift
//  GMS Admin
//
//  Created by HappysanziMac on 19/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class CheckConstituentService {
    
      public func callAPIcheckConstituent(constituency_code:String, onSuccess successCallback: ((_ constituencyName: [CheckConstituentModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPIcheckConstituent(
            constituency_code: constituency_code, onSuccess: { (constituencyName) in
                  successCallback?(constituencyName)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }
}
