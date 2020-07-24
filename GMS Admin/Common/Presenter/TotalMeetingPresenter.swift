//
//  TotalMeetingPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct TotalMeetingData {
    let meeting_count : Int?
    let requested_count: Int?
    let completed_count: Int?
}

protocol TotalMeetingView : NSObjectProtocol {
    func startLoadingTm()
    func finishLoadingTm()
    func setTm(meeting_count: Int?, requested_count:Int?, completed_count:Int?)
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
    
    func getTotalMeeting(paguthi:String) {
        self.totalMeetingView?.startLoadingTm()
        totalMeetingService.callAPITotalMeetings(
            paguthi: paguthi, onSuccess: { (tm) in
                self.totalMeetingView?.finishLoadingTm()
                self.totalMeetingView?.setTm(meeting_count: tm.meeting_count!, requested_count: tm.requested_count!, completed_count: tm.completed_count!)
            },
            onFailure: { (errorMessage) in
                self.totalMeetingView?.finishLoadingTm()
                self.totalMeetingView?.setEmptyTm(errorMessage: errorMessage)

            }
        )
    }

}
