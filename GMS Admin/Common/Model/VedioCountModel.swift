//
//  VedioCountModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 21/04/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation


class VedioCountModel: NSObject {
    
    var office_name: String?
    var video_cnt: String?
    var video_percentage : String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["office_name"] as? String {
            self.office_name = data
        }
        if let data = dict["video_cnt"] as? String {
            self.video_cnt = data
        }
        if let data = dict["video_percentage"] as? String {
            self.video_percentage = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> VedioCountModel {
        let vedioCountModel = VedioCountModel()
        vedioCountModel.loadFromDictionary(dict)
        return vedioCountModel
    }
}
