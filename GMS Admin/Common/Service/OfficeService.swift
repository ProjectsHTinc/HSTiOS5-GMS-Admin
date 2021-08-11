//
//  OfficeService.swift
//  GMS Admin
//
//  Created by HappysanziMac on 29/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation


import UIKit

class OfficeService {
    
    public func callAPIOffice(constituency_id:String,dynamic_db:String, onSuccess successCallback: ((_ office: [OfficeModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIOffice(
            constituency_id: constituency_id,dynamic_db:dynamic_db, onSuccess: { (office) in
                successCallback?(office)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
