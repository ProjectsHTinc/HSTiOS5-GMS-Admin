//
//  ConstituentMemberService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentMemberService: NSObject {
    
    public func callAPIConstituentMembers(paguthi:String, onSuccess successCallback: ((_ constituentMember: ConstituentMemberModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIConstituentMembers(
          paguthi: paguthi, onSuccess: { (constituentMember) in
                successCallback?(constituentMember)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
