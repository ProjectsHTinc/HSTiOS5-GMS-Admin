//
//  SeekerNameService.swift
//  GMS Admin
//
//  Created by HappysanziMac on 12/08/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//



import Foundation
import UIKit

class SeekerTypeService: NSObject {

    public func callAPIseekerType(user_id:String,dynamic_db:String, onSuccess successCallback: ((_ caategoeryModel: [SeekerTypeModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPISeekerType(
            dynamic_db:dynamic_db, user_id : user_id, onSuccess: { (caategoeryModel) in
                successCallback?(caategoeryModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
