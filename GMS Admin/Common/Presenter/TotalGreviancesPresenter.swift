//
//  TotalGreviancesPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct TotalGrevianceData {
    
    var tot_grive_count: Int?
    var enquiry_count: String?
    var petition_count : String?
//    var processing_count : String?
    var completed_count : String?
    
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
    
}

protocol TotalGrevianceView : NSObjectProtocol {
    func startLoadingTg()
    func finishLoadingTg()
    func setTg(tot_grive_count: Int?, enquiry_count:String?, petition_count:String?, petition_rejected_percentageOnline: String?,no_of_civicOnline: String?,no_of_online_percentageOnline:String?,petition_completedOnline : String?,petition_pendingOnline : String?,petition_pending_percentageOnline : String?,petition_rejectedOnline : String?,petition_rejected_percentageCivic: String?,petition_rejectedCivic: String?,petition_completed_percentageCivic : String?,petition_completedCivic : String?,petition_pendingCivic : String?,no_of_civic_percentageEQ : String?,no_of_civicEQ : String?,no_of_online_percentageEQ : String?,no_of_onlineEQ : String?,no_of_online : String?,no_of_online_percentage : String?,no_of_civic : String?,no_of_civic_percentage : String?,petition_pending_percentage: String?,petition_pending : String?,petition_rejected_percentage : String?,petition_rejected : String?,petition_completed : String?,petition_completed_percentage: String?)

    
    
    func setEmptyTg(errorMessage:String)
}

class TotalGreviancesPresenter: NSObject {
    
    private let totalGreviancesSerVice:TotalGreviancesSerVice
    weak private var totalGrevianceView : TotalGrevianceView?
    
    init(totalGreviancesSerVice:TotalGreviancesSerVice) {
        self.totalGreviancesSerVice = totalGreviancesSerVice
    }
    
    func attachView(view:TotalGrevianceView) {
        totalGrevianceView = view
    }
    
    func detachView() {
        totalGrevianceView = nil
    }
    
    func getTotalGreviances(paguthi:String,from_date:String,to_date:String,dynamic_db:String) {
        self.totalGrevianceView?.startLoadingTg()
        totalGreviancesSerVice.callAPITotalGreivances(
            paguthi: paguthi,from_date:from_date,to_date:to_date,dynamic_db:dynamic_db, onSuccess: { (tg) in
                self.totalGrevianceView?.finishLoadingTg()
                self.totalGrevianceView?.setTg(tot_grive_count: tg.tot_grive_count,
                                               enquiry_count: tg.enquiry_count,
                                               petition_count: tg.petition_count,
                                               petition_rejected_percentageOnline: tg.petition_rejected_percentageOnline,
                                               no_of_civicOnline: tg.no_of_civicOnline,
                                               no_of_online_percentageOnline: tg.no_of_online_percentageOnline,
                                               petition_completedOnline: tg.petition_completedOnline,
                                               petition_pendingOnline: tg.petition_pendingOnline,
                                               petition_pending_percentageOnline: tg.petition_pending_percentageOnline,
                                               petition_rejectedOnline: tg.petition_rejectedOnline,
                                               petition_rejected_percentageCivic: tg.petition_rejected_percentageCivic,
                                               petition_rejectedCivic: tg.petition_rejectedCivic,
                                               petition_completed_percentageCivic: tg.petition_completed_percentageCivic,
                                               petition_completedCivic: tg.petition_completedCivic,
                                               petition_pendingCivic: tg.petition_pending_percentageCivic,
                                               no_of_civic_percentageEQ: tg.no_of_civic_percentageEQ,
                                               no_of_civicEQ: tg.no_of_online_percentageEQ,
                                               no_of_online_percentageEQ: tg.no_of_civicEQ, no_of_onlineEQ: tg.no_of_onlineEQ,
                                               no_of_online:tg.no_of_online_percentage,
                                               no_of_online_percentage: tg.no_of_online,
                                               no_of_civic: tg.no_of_civic,
                                               no_of_civic_percentage: tg.no_of_civic_percentage,
                                               petition_pending_percentage: tg.petition_pending_percentage,
                                               petition_pending: tg.petition_pending,
                                               petition_rejected_percentage: tg.petition_rejected_percentage,
                                               petition_rejected: tg.petition_rejected,
                                               petition_completed: tg.petition_completed,
                                               petition_completed_percentage: tg.petition_completed_percentage)
            },
            onFailure: { (errorMessage) in
                self.totalGrevianceView?.startLoadingTg()
                self.totalGrevianceView?.setEmptyTg(errorMessage: errorMessage)

            }
        )
    }
}
