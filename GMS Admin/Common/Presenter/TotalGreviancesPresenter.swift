//
//  TotalGreviancesPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct TotalGrevianceData {
    let grievance_count : Int?
    let enquiry_count: Int?
    let petition_count: Int?
    let processing_count: Int?
    let completed_count: Int?
}

protocol TotalGrevianceView : NSObjectProtocol {
    func startLoadingTg()
    func finishLoadingTg()
    func setTg(grievance_count: Int?, enquiry_count:Int?, petition_count:Int?, processing_count:Int?, completed_count:Int?)
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
    
    func getTotalGreviances(paguthi:String) {
        self.totalGrevianceView?.startLoadingTg()
        totalGreviancesSerVice.callAPITotalGreivances(
            paguthi: paguthi, onSuccess: { (tg) in
                self.totalGrevianceView?.finishLoadingTg()
                self.totalGrevianceView?.setTg(grievance_count: tg.grievance_count!, enquiry_count: tg.enquiry_count!, petition_count: tg.petition_count!, processing_count: tg.processing_count!, completed_count: tg.completed_count!)
            },
            onFailure: { (errorMessage) in
                self.totalGrevianceView?.startLoadingTg()
                self.totalGrevianceView?.setEmptyTg(errorMessage: errorMessage)

            }
        )
    }

}
