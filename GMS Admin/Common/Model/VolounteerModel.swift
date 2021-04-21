//
//  VolounteerModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 21/04/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation

class VolounteerModel {
    
    var total_volunteer : String?
    var no_of_volunteer : String?
    var volunteer_percentage: String?
    var no_of_nonvolunteer: String?
    var nonvolunteer_percentage : String?
   
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["total_volunteer"] as? String {
            self.total_volunteer = data
        }
        
        if let data = dict["no_of_volunteer"] as? String {
            self.no_of_volunteer = data
        }
        
        if let data = dict["volunteer_percentage"] as? String {
            self.volunteer_percentage = data
        }
        
        if let data = dict["no_of_nonvolunteer"] as? String {
            self.no_of_nonvolunteer = data
        }
        
        if let data = dict["nonvolunteer_percentage"] as? String {
            self.nonvolunteer_percentage = data
        }
    }
}
