//
//  TotalMeetingPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct TotalMeetingData {
    var total_meeting: String?
    var request_count_percentage: String?
    var request_count : String?
    var complete_count: String?
    var complete_count_percentage : String?
}

protocol TotalMeetingView : NSObjectProtocol {
    func startLoadingTm()
    func finishLoadingTm()
    func setTm(total_meeting: String?, request_count_percentage:String?, request_count:String?,complete_count: String?,complete_count_percentage : String?)
    func setEmptyTm(errorMessage:String)
}

class TotalMeetingPresenter: NSObject {
    
    private let totalMeetingService:TotalMeetingService
    weak private var totalMeetingView : TotalMeetingView?
    
    init(totalMeetingService:TotalMeetingService) {
        self.totalMeetingService = totalMeetingService
    }
    
    func attachView(view:TotalMeetingView) {
        totalMeetingView = view
    }
    
    func detachView() {
        totalMeetingView = nil
    }
    
    func getTotalMeeting(paguthi:String,from_date:String,to_date:String) {
        self.totalMeetingView?.startLoadingTm()
        totalMeetingService.callAPITotalMeetings(
            paguthi: paguthi,to_date:to_date, from_date:from_date, onSuccess: { (tm) in
                self.totalMeetingView?.finishLoadingTm()
                self.totalMeetingView?.setTm(total_meeting: tm.total_meeting, request_count_percentage: tm.request_count_percentage!, request_count: tm.request_count!, complete_count: tm.complete_count!, complete_count_percentage: tm.complete_count_percentage!)
            },
            onFailure: { (errorMessage) in
                self.totalMeetingView?.finishLoadingTm()
                self.totalMeetingView?.setEmptyTm(errorMessage: errorMessage)

            }
        )
    }

}
