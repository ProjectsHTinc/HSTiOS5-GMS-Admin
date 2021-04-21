//
//  TotalGreviancesModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class TotalGreviancesModel: NSObject {
    
    var tot_grive_count: Int?
    var enquiry_count: String?
    var petition_count : String?
//    var processing_count : String?
//    var completed_count : String?
    var petition_rejected_percentageOnline: String?
    var no_of_civicOnline: String?
    var no_of_online_percentageOnline : String?
    var petition_completedOnline : String?
    var petition_pendingOnline : String?
    var petition_pending_percentageOnline : String?
    var petition_rejectedOnline : String?
    var petition_rejected_percentageCivic: String?
    var petition_rejectedCivic: String?
    var petition_completed_percentageCivic : String?
    var petition_completedCivic : String?
    var petition_pending_percentageCivic : String?
    var petition_pendingCivic : String?
    var no_of_civic_percentageEQ : String?
    var no_of_civicEQ : String?
    var no_of_online_percentageEQ : String?
    var no_of_onlineEQ : String?
    var civic_petition_count : String?
    var online_petition_count : String?
    var no_of_online : String?
    var no_of_online_percentage : String?
    var no_of_civic : String?
    var no_of_civic_percentage : String?
    var petition_pending_percentage: String?
    var petition_completed_percentage: String?
    var petition_pending : String?
    var petition_rejected_percentage : String?
    var petition_rejected : String?
    var petition_completed : String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["tot_grive_count"] as? Int {
            self.tot_grive_count = data
        }
        if let data = dict["enquiry_count"] as? String {
            self.enquiry_count = data
        }
        if let data = dict["petition_count"] as? String {
            self.petition_count = data
        }
//        if let data = dict["processing_count"] as? String {
//            self.processing_count = data
//        }
        if let data = dict["petition_rejected_percentage"] as? String {
            self.petition_rejected_percentageOnline = data
        }
        if let data = dict["petition_pending"] as? String {
            self.petition_pendingOnline = data
        }
        if let data = dict["petition_pending_percentage"] as? String {
            self.petition_pending_percentageOnline = data
        }
        if let data = dict["petition_completed_percentage"] as? String {
            self.no_of_online_percentageOnline = data
        }
        if let data = dict["petition_completed"] as? String {
            self.petition_completedOnline = data
        }
        if let data = dict["petition_rejected"] as? String {
            self.petition_rejectedOnline = data
        }
        if let data = dict["petition_rejected_percentage"] as? String {
            self.petition_rejected_percentageCivic = data
        }
        if let data = dict["online_petition_count"] as? String {
            self.online_petition_count = data
        }
        if let data = dict["civic_petition_count"] as? String {
            self.civic_petition_count = data
        }
        if let data = dict["petition_rejected"] as? String {
            self.petition_rejectedCivic = data
        }
        if let data = dict["petition_completed_percentage"] as? String {
            self.petition_completed_percentageCivic = data
        }
        if let data = dict["petition_completed"] as? String {
            self.petition_completedCivic = data
        }
        if let data = dict["petition_pending_percentage"] as? String {
            self.petition_pending_percentageCivic = data
        }
        if let data = dict["petition_pending"] as? String {
            self.petition_pendingCivic = data
        }
        if let data = dict["no_of_civic_percentage"] as? String {
            self.no_of_civic_percentageEQ = data
        }
        if let data = dict["no_of_civic"] as? String {
            self.no_of_civicEQ = data
        }
        if let data = dict["no_of_online_percentage"] as? String {
            self.no_of_online_percentageEQ = data
        }
        if let data = dict["no_of_online"] as? String {
            self.no_of_onlineEQ = data
        }
        if let data = dict["no_of_online"] as? String {
            self.no_of_online = data
        }
        if let data = dict["no_of_online_percentage"] as? String {
            self.no_of_online_percentage = data
        }
        if let data = dict["no_of_civic"] as? String {
            self.no_of_civic = data
        }
        if let data = dict["no_of_civic_percentage"] as? String {
            self.no_of_civic_percentage = data
        }
        if let data = dict["petition_pending_percentage"] as? String {
            self.petition_pending_percentage = data
        }
        if let data = dict["petition_completed_percentage"] as? String {
            self.petition_completed_percentage = data
        }
        if let data = dict["petition_rejected_percentage"] as? String {
            self.petition_rejected_percentage = data
        }
        if let data = dict["petition_pending"] as? String {
            self.petition_pending = data
        }
        if let data = dict["petition_rejected"] as? String {
            self.petition_rejected = data
        }
        if let data = dict["petition_completed"] as? String {
            self.petition_completed = data
        }
        
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> TotalGreviancesModel {
        let totalGreviancesModel = TotalGreviancesModel()
        totalGreviancesModel.loadFromDictionary(dict)
        return totalGreviancesModel
    }

}
