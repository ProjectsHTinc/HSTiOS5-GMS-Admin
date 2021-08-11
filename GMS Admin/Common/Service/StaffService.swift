//
//  StaffService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class StaffService: NSObject {
    
    public func callAPIStaff(constituency_id : String, dynamic_db:String,onSuccess successCallback: ((_ staffModel: [StaffModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIStaff(
            dynamic_db:dynamic_db, constituency_id: constituency_id,  onSuccess: { (staffModel) in
                successCallback?(staffModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
