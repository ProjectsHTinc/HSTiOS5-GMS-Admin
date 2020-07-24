//
//  StaffDetailService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class StaffDetailService: NSObject {
    
    public func callAPIStaffDetail(staff_id : String, onSuccess successCallback: ((_ staffDetailModel: [StaffDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIStaffDetail(
            staff_id: staff_id,  onSuccess: { (staffDetailModel) in
                successCallback?(staffDetailModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
