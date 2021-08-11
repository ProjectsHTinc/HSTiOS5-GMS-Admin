//
//  ListConstituentservice.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 13/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ListConstituentservice {
    
    public func callAPIConstituentList(url:String,Keyword:String,paguthi:String, offset:String, rowcount:String,dynamic_db:String, onSuccess successCallback: ((_ listConstiuentModel: [ListConstiuentModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIConstituentList(
            dynamic_db:dynamic_db, url:url,Keyword:Keyword,paguthi: paguthi,offset: offset, rowcount: rowcount, onSuccess: { (listConstiuentModel) in
                successCallback?(listConstiuentModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
