//
//  File.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import Foundation

class VedioCountService: NSObject {
    
    public func callAPIVedioCount(paguthi:String,from_date:String,to_date:String,onSuccess successCallback: ((_ vedioCount: [VedioCountModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIVedioCount(
            paguthi: paguthi,from_date:from_date,to_date:to_date, onSuccess: { (vedioCount) in
                successCallback?(vedioCount)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
