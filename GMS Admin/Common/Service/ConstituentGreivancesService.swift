//
//  ConstituentGreivancesService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 20/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentGreivancesService {
    
    public func callAPIConstituentGrievances(constituent_id:String,dynamic_db:String, onSuccess successCallback: ((_ constituentGreivancesModel: [ConstituentGreivancesModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIConstituentGrievances(
            dynamic_db:dynamic_db, constituent_id: constituent_id, onSuccess: { (constituentGreivancesModel) in
                successCallback?(constituentGreivancesModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
