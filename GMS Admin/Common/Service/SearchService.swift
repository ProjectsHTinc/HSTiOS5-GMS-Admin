//
//  SearchService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 07/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class SearchService {
    
    public func callAPISearch(keyword:String, offset:String, rowcount:String, onSuccess successCallback: ((_ search: [SearchModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPISearch(
          keyword: keyword, offset: offset, rowcount: rowcount, onSuccess: { (search) in
                successCallback?(search)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
