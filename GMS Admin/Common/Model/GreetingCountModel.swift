//
//  GreetingCountModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 21/04/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation

class GreetingCountModel: NSObject {
    
    var festival_name: String?
    var festival_wish_cnt: String?
    var festival_wishes_percentage : String?
  
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["festival_name"] as? String {
            self.festival_name = data
        }
        if let data = dict["festival_wish_cnt"] as? String {
            self.festival_wish_cnt = data
        }
        if let data = dict["festival_wishes_percentage"] as? String {
            self.festival_wishes_percentage = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> GreetingCountModel {
        let greetingCountModel = GreetingCountModel()
        greetingCountModel.loadFromDictionary(dict)
        return greetingCountModel
    }
}
