//
//  ConstituentInteractionService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentInteractionService: NSObject {
    
    public func callAPIConstituentIneraction(paguthi:String, dynamic_db:String,onSuccess successCallback: ((_ constituentInteractionModel: [ConstituentInteractionModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIConstituentInteraction(
            dynamic_db:dynamic_db, paguthi: paguthi, onSuccess: { (constituentInteractionModel) in
                successCallback?(constituentInteractionModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
