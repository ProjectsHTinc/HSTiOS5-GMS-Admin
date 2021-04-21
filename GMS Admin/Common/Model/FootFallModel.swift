//
//  FootFallModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import Foundation

class FootFallModel {
    
    var total_footfall_cnt : Int?
    var unique_footfall_cnt : Int?
    var repeated_footfall_cnt: Int?
    var unique_footfall_cnt_presntage: String?
    var repeated_footfall_cnt_presntage : String?
    var total_unique_footfall_cnt : Int?
    var other_unique_footfall_cnt: Int?
    var cons_unique_footfall_cnt: Int?
    var cons_unique_footfall_cnt_presntage: String?
    var other_unique_footfall_cnt_presntage: String?
    var constituency_cnt: Int?
    var cons_unique_cnt: Int?
    var cons_repeated_cnt: Int?
    var cons_unique_cnt_presntage: String?
    var cons_repeated_cnt_presntage: String?
    var other_cnt: Int?
    var other_unique_cnt: Int?
    var other_repeated_cnt: Int?
    var other_unique_cnt_presntage: String?
    var other_repeated_cnt_presntage: String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["total_footfall_cnt"] as? Int {
            self.total_footfall_cnt = data
        }
        
        if let data = dict["unique_footfall_cnt"] as? Int {
            self.unique_footfall_cnt = data
        }
        
        if let data = dict["repeated_footfall_cnt"] as? Int {
            self.repeated_footfall_cnt = data
        }
        
        if let data = dict["unique_footfall_cnt_presntage"] as? String {
            self.unique_footfall_cnt_presntage = data
        }
        
        if let data = dict["repeated_footfall_cnt_presntage"] as? String {
            self.repeated_footfall_cnt_presntage = data
        }
        
        if let data = dict["total_unique_footfall_cnt"] as? Int {
            self.total_unique_footfall_cnt = data
        }
        
        if let data = dict["other_unique_footfall_cnt"] as? Int {
            self.cons_unique_footfall_cnt = data
        }
        
        if let data = dict["cons_unique_footfall_cnt"] as? Int {
            self.cons_unique_footfall_cnt = data
        }
        
        if let data = dict["cons_unique_footfall_cnt_presntage"] as? String {
            self.cons_unique_footfall_cnt_presntage = data
        }
        
        if let data = dict["other_unique_footfall_cnt_presntage"] as? String {
            self.other_unique_footfall_cnt_presntage = data
        }
        
        if let data = dict["constituency_cnt"] as? Int {
            self.constituency_cnt = data
        }
        
        if let data = dict["cons_unique_cnt"] as? Int {
            self.cons_unique_cnt = data
        }
        
        if let data = dict["cons_repeated_cnt"] as? Int {
            self.cons_repeated_cnt = data
        }
        
        if let data = dict["cons_unique_cnt_presntage"] as? String {
            self.cons_unique_cnt_presntage = data
        }
        
        if let data = dict["cons_repeated_cnt_presntage"] as? String {
                self.cons_repeated_cnt_presntage = data
            }
            
        if let data = dict["other_cnt"] as? Int {
                self.other_cnt = data
            }
            
        if let data = dict["other_unique_cnt"] as? Int {
                self.other_unique_cnt = data
            }
            
        if let data = dict["other_repeated_cnt"] as? Int {
                self.other_repeated_cnt = data
            }
            
        if let data = dict["other_unique_cnt_presntage"] as? String {
                self.other_unique_cnt_presntage = data
            }
           
        if let data = dict["other_repeated_cnt_presntage"] as? String {
             self.other_repeated_cnt_presntage = data
            }
        
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> FootFallModel {
        let footFallModel = FootFallModel()
        footFallModel.loadFromDictionary(dict)
        return footFallModel
    }

}
