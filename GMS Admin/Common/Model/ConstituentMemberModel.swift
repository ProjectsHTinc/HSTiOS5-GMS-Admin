//
//  ConstituentMemberModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentMemberModel: NSObject {
    
    var total: String?
    var malecount: String?
    var malepercenatge : String?
    var femalecount : String?
    var femalepercenatge: String?
    var others: String?
    var otherpercenatge : String?
    var malevoter_percentage : String?
    var femalevoter: String?
    var femalevoter_percentage: String?
    var maleaadhar : String?
    var maleaadhaar_percentage : String?
    var femaleaadhar: String?
    var femaleaadhaar_percentage: String?
    var having_mobilenumber : String?
    var mobile_percentage : String?
    var having_email: String?
    var email_percentage: String?
    var having_whatsapp : String?
    var whatsapp_percentage : String?
    var having_whatsapp_broadcast: String?
    var broadcast_percentage: String?
    var having_voter_percenatge : String?
    var having_vote_id : String?
    var having_dob_percentage: String?
    var having_dob: String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["total"] as? String {
            self.total = data
        }
        if let data = dict["malecount"] as? String {
            self.malecount = data
        }
        if let data = dict["malepercenatge"] as? String {
            self.malepercenatge = data
        }
        if let data = dict["femalecount"] as? String {
            self.femalecount = data
        }
        
        if let data = dict["femalepercenatge"] as? String {
            self.femalepercenatge = data
        }
        if let data = dict["others"] as? String {
            self.others = data
        }
        if let data = dict["otherpercenatge"] as? String {
            self.otherpercenatge = data
        }
        if let data = dict["malevoter_percentage"] as? String {
            self.malevoter_percentage = data
        }
        
        if let data = dict["femalevoter"] as? String {
            self.femalevoter = data
        }
        if let data = dict["femalevoter_percentage"] as? String {
            self.femalevoter_percentage = data
        }
        if let data = dict["having_mobilenumber"] as? String {
            self.having_mobilenumber = data
        }
        if let data = dict["mobile_percentage"] as? String {
            self.mobile_percentage = data
        }
        
        if let data = dict["having_email"] as? String {
            self.having_email = data
        }
        if let data = dict["email_percentage"] as? String {
            self.email_percentage = data
        }
        if let data = dict["having_whatsapp"] as? String {
            self.having_whatsapp = data
        }
        if let data = dict["whatsapp_percentage"] as? String {
            self.whatsapp_percentage = data
        }
        
        if let data = dict["having_whatsapp_broadcast"] as? String {
            self.having_whatsapp_broadcast = data
        }
        if let data = dict["broadcast_percentage"] as? String {
            self.broadcast_percentage = data
        }
        if let data = dict["having_voter_percenatge"] as? String {
            self.having_voter_percenatge = data
        }
        if let data = dict["having_vote_id"] as? String {
            self.having_vote_id = data
        }
        
        if let data = dict["having_dob_percentage"] as? String {
            self.having_dob_percentage = data
        }
        if let data = dict["having_dob"] as? String {
            self.having_dob = data
        }
        
        
        
        
        
        
        
        
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ConstituentMemberModel {
        let constituentMemberModel = ConstituentMemberModel()
        constituentMemberModel.loadFromDictionary(dict)
        return constituentMemberModel
    }

}
