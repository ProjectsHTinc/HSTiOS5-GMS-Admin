//
//  ConstituentDetailModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 13/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentDetailModel {
    
    var constituency_name: String?
    var paguthi_name: String?
    var ward_name : String?
    var booth_name : String?
    var id : String?
    var constituency_id : String?
    var paguthi_id : String?
    var ward_id : String?
    var booth_id : String?
    var full_name : String?
    var father_husband_name : String?
    var guardian_name : String?
    var mobile_no : String?
    var mobile_otp : String?
    var whatsapp_no : String?
    var dob : String?
    var door_no : String?
    var address : String?
    var pin_code : String?
    var religion_id : String?
    var email_id : String?
    var gender : String?
    var voter_id_status : String?
    var voter_id_no : String?
    var aadhaar_status : String?
    var aadhaar_no : String?
    var party_member_status : String?
    var vote_type : String?
    var profile_pic : String?
    var religion_name : String?
    var booth_address : String?
    var serial_no : String?

    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["constituency_name"] as? String {
            self.constituency_name = data
        }
        if let data = dict["paguthi_name"] as? String {
            self.paguthi_name = data
        }
        if let data = dict["ward_name"] as? String {
            self.ward_name = data
        }
        if let data = dict["booth_name"] as? String {
            self.booth_name = data
        }
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["constituency_id"] as? String {
            self.constituency_id = data
        }
        if let data = dict["paguthi_id"] as? String {
            self.paguthi_id = data
        }
        if let data = dict["ward_id"] as? String {
            self.ward_id = data
        }
        if let data = dict["booth_id"] as? String {
            self.booth_id = data
        }
        if let data = dict["full_name"] as? String {
            self.full_name = data
        }
        if let data = dict["father_husband_name"] as? String {
            self.father_husband_name = data
        }
        if let data = dict["guardian_name"] as? String {
            self.guardian_name = data
        }
        if let data = dict["mobile_no"] as? String {
            self.mobile_no = data
        }
        if let data = dict["mobile_otp"] as? String {
            self.mobile_otp = data
        }
        if let data = dict["whatsapp_no"] as? String {
            self.whatsapp_no = data
        }
        if let data = dict["dob"] as? String {
            self.dob = data
        }
        if let data = dict["door_no"] as? String {
            self.door_no = data
        }
        if let data = dict["address"] as? String {
            self.address = data
        }
        if let data = dict["pin_code"] as? String {
            self.pin_code = data
        }
        if let data = dict["religion_id"] as? String {
            self.religion_id = data
        }
        if let data = dict["email_id"] as? String {
            self.email_id = data
        }
        if let data = dict["gender"] as? String {
            self.gender = data
        }
        if let data = dict["voter_id_status"] as? String {
            self.voter_id_status = data
        }
        if let data = dict["voter_id_no"] as? String {
            self.voter_id_no = data
        }
        if let data = dict["aadhaar_status"] as? String {
            self.aadhaar_status = data
        }
        if let data = dict["aadhaar_no"] as? String {
            self.aadhaar_no = data
        }
        if let data = dict["party_member_status"] as? String {
            self.party_member_status = data
        }
        if let data = dict["vote_type"] as? String {
            self.vote_type = data
        }
        if let data = dict["profile_pic"] as? String {
            self.profile_pic = data
        }
        if let data = dict["religion_name"] as? String {
            self.religion_name = data
        }
        if let data = dict["booth_address"] as? String {
            self.booth_address = data
        }
        if let data = dict["serial_no"] as? String {
            self.serial_no = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ConstituentDetailModel {
        let constituentDetailModel = ConstituentDetailModel()
        constituentDetailModel.loadFromDictionary(dict)
        return constituentDetailModel
    }

}
