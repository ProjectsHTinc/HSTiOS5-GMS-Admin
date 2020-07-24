//
//  AFWrapper.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 08/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper


class AFWrapper: NSObject {
    
    public static let sharedManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        let manager = Alamofire.SessionManager(configuration: configuration, delegate: SessionManager.default.delegate)
        return manager
    }()
    
    class func requestPOSTURL(_ strURL : String, params : [String:String]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void)
    throws {
        
        sharedManager.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            
            if responseObject.result.isFailure
            {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }

}
