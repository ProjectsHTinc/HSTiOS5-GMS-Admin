//
//  SubCategoeryService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class SubCategoeryService: NSObject {
    
    public func callAPISubCategoery(user_id : String, onSuccess successCallback: ((_ subCategoeryModel: [SubCategoeryModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPISubCategoery(
            user_id:user_id,  onSuccess: { (subCategoeryModel) in
                successCallback?(subCategoeryModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
