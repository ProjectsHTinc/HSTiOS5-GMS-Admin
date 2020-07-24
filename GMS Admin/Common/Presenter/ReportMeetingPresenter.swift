//
//  ReportMeetingPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ReportMeetingData {
    let id : String
    let full_name : String
    let paguthi_name : String
    let meeting_title : String
    let meeting_date : String
    let meeting_status : String
    let created_by : String
}

protocol ReportMeetingView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setReport(report: [ReportMeetingData])
    func setEmpty(errorMessage:String)
}

class ReportMeetingPresenter: NSObject {
    
    private let reportMeetingService: ReportMeetingService
    weak private var reportMeetingView : ReportMeetingView?

    init(reportMeetingService:ReportMeetingService) {
        self.reportMeetingService = reportMeetingService
    }
    
    func attachView(view:ReportMeetingView) {
        reportMeetingView = view
    }
    
    func detachView() {
        reportMeetingView = nil
    }
    
    func getReportMeeting(url: String, keyword: String, from_date:String, to_date:String, offset:String, rowcount:String) {
          self.reportMeetingView?.startLoading()
          reportMeetingService.callAPIReportMeeting(
            url: url, keyword: keyword, from_date: from_date, to_date: to_date, offset: offset, rowcount: rowcount, onSuccess: { (meettingAll) in
            self.reportMeetingView?.finishLoading()
                if (meettingAll.count == 0){
                } else {
                  let mappedUsers = meettingAll.map {
                    return ReportMeetingData(id: "\($0.id ?? "")", full_name: "\($0.full_name ?? "")", paguthi_name: "\($0.paguthi_name ?? "")", meeting_title: "\($0.meeting_title ?? "")", meeting_date: "\($0.meeting_date ?? "")", meeting_status: "\($0.meeting_status ?? "")", created_by: "\($0.created_by ?? "")")
                     }
                    self.reportMeetingView?.setReport(report: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.reportMeetingView?.finishLoading()
                  self.reportMeetingView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
