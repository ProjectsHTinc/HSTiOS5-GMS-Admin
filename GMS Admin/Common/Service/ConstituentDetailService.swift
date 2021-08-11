//
//  ConstituentDetailService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 13/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentDetailService {
    
    public func callAPIConstituentDetail(constituent_id:String,dynamic_db:String,onSuccess successCallback: ((_ constituentDetailModel: [ConstituentDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIConstituentDetail(
            dynamic_db:dynamic_db, constituent_id: constituent_id,onSuccess: { (constituentDetailModel) in
                successCallback?(constituentDetailModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
