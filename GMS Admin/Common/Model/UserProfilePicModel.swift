//
//  UserProfilePicModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class UserProfilePicModel: NSObject {
    
    var status: String?
    var msg: String?
    var picture_url : String?



    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["status"] as? String {
            self.status = data
        }
        if let data = dict["msg"] as? String {
            self.msg = data
        }
        if let data = dict["picture_url"] as? String {
            self.picture_url = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> UserProfilePicModel {
        let userProfilePicModel = UserProfilePicModel()
        userProfilePicModel.loadFromDictionary(dict)
        return userProfilePicModel
    }

}
