//
//  ConsDocumentService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConsDocumentService {

    public func callAPIConsDocument(constituent_id:String, onSuccess successCallback: ((_ consDocumentModel: [ConsDocumentModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIConsDocument(
          constituent_id: constituent_id, onSuccess: { (consDocumentModel) in
                successCallback?(consDocumentModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
