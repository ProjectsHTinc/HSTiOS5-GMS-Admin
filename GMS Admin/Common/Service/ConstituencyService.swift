//
//  ConstituencyService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 27/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituencyService {
    
    public func callAPIGetConstituencyList(partyID:String,onSuccess successCallback: ((_ constituencyName: [ConstituencyModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIGetConstituencyList(
            partyID: partyID, onSuccess: { (constituencyName) in
                successCallback?(constituencyName)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
