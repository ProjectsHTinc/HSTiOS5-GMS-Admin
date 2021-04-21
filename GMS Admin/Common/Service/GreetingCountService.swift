//
//  GreetingCountModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit


class GreetingCountService: NSObject {
    
    public func callAPIGreetingCount(paguthi:String,from_date:String,to_date:String,onSuccess successCallback: ((_ greetingCountModel: [GreetingCountModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIGreetingCount(
            paguthi: paguthi,from_date:from_date,to_date:to_date, onSuccess: { (greetingCountModel) in
                successCallback?(greetingCountModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
