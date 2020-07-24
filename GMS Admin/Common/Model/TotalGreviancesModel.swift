//
//  TotalGreviancesModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class TotalGreviancesModel: NSObject {
    
    var grievance_count: Int?
    var enquiry_count: Int?
    var petition_count : Int?
    var processing_count : Int?
    var completed_count : Int?


    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["grievance_count"] as? Int {
            self.grievance_count = data
        }
        if let data = dict["enquiry_count"] as? Int {
            self.enquiry_count = data
        }
        if let data = dict["petition_count"] as? Int {
            self.petition_count = data
        }
        if let data = dict["processing_count"] as? Int {
            self.processing_count = data
        }
        if let data = dict["completed_count"] as? Int {
            self.completed_count = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> TotalGreviancesModel {
        let totalGreviancesModel = TotalGreviancesModel()
        totalGreviancesModel.loadFromDictionary(dict)
        return totalGreviancesModel
    }

}
