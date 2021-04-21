//
//  VolounteerCountService.swift
//  GMS Admin
//
//  Created by HappysanziMac on 21/04/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation

class VolounteerService : NSObject {

    public func callAPIVolounteer(paguthi:String,from_date:String,to_date:String, onSuccess successCallback: ((_ volounteerModel: VolounteerModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIVolounteer(
            paguthi: paguthi,from_date:from_date,to_date: to_date, onSuccess: { (volounteerModel) in
                successCallback?(volounteerModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
