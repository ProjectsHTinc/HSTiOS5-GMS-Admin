//
//  GriDocumentService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class GriDocumentService {

    public func callAPIGriDocument(constituent_id:String, onSuccess successCallback: ((_ griDocumentModel: [GriDocumentModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIGriDocument(
          constituent_id: constituent_id, onSuccess: { (griDocumentModel) in
                successCallback?(griDocumentModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
    
}
