//
//  AreaService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 08/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class AreaService {
    
    public func callAPIPaguthi(constituency_id:String,dynamic_db:String, onSuccess successCallback: ((_ paguthi: [AreaModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIPaguthi(
            constituency_id: constituency_id,dynamic_db:dynamic_db, onSuccess: { (paguthi) in
                successCallback?(paguthi)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
