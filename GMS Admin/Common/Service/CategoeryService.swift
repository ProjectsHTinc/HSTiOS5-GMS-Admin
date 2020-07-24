//
//  CategoeryService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class CategoeryService: NSObject {

    public func callAPICategoery(user_id : String, onSuccess successCallback: ((_ caategoeryModel: [CaategoeryModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPICategoery(
            user_id:user_id,  onSuccess: { (caategoeryModel) in
                successCallback?(caategoeryModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
