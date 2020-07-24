//
//  InteractionService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class InteractionService {
    
    public func callAPIInteraction(constituent_id:String, onSuccess successCallback: ((_ interactionModel: [InteractionModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIInteraction(
          constituent_id: constituent_id, onSuccess: { (interactionModel) in
                successCallback?(interactionModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
