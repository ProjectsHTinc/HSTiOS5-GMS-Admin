//
//  ConstituentMemberModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentMemberModel: NSObject {
    
    var member_count: Int?
    var male_count: Int?
    var female_count : Int?
    var voterid_count : Int?
    var aadhaar_count : Int?


    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["member_count"] as? Int? {
            self.member_count = data
        }
        if let data = dict["male_count"] as? Int? {
            self.male_count = data
        }
        if let data = dict["female_count"] as? Int? {
            self.female_count = data
        }
        if let data = dict["voterid_count"] as? Int? {
            self.voterid_count = data
        }
        if let data = dict["aadhaar_count"] as? Int? {
            self.aadhaar_count = data
        }

    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ConstituentMemberModel {
        let constituentMemberModel = ConstituentMemberModel()
        constituentMemberModel.loadFromDictionary(dict)
        return constituentMemberModel
    }

}
