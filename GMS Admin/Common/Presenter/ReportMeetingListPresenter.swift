//
//  ReportMeetingListPresenter.swift
//  GMS Admin
//
//  Created by HappysanziMac on 02/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

struct ReportMeetingListData {
    
    let id : String
    let paguthi_name : String
    let full_name : String
    let mobile_no : String
    let created_by : String
    let door_no : String
    var address : String?
    var father_husband_name : String
    var office_name : String
    var pin_code : String
    var dob : String
    var meeting_date : String
    var meeting_status : String
}

protocol ReportMeetingListView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setReport(report: [ReportMeetingListData])
    func setEmpty(errorMessage:String)
}

class ReportMeetingListPresenter: NSObject {
    
    private let reportMeetingListService: ReportMeetingListService
    weak private var reportMeetingListView : ReportMeetingListView?

    init(reportMeetingListService:ReportMeetingListService) {
        self.reportMeetingListService = reportMeetingListService
    }
    
    func attachView(view:ReportMeetingListView) {
        reportMeetingListView = view
    }
    
    func detachView() {
        reportMeetingListView = nil
    }
    
    func getMeetingReportList(url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String) {
          self.reportMeetingListView?.startLoading()
        reportMeetingListService.callAPIReportMeetingList(
            url : url,From: From,from_date: from_date,to_date: to_date,status: status,paguthi: paguthi,offset: offset,rowcount: rowcount,category: category,sub_category: sub_category,keyword: keyword,dynamic_db:dynamic_db,office:office, onSuccess: { (report) in
            self.reportMeetingListView?.finishLoading()
                if (report.count == 0){
                } else {
                  let mappedUsers = report.map {
                    return ReportMeetingListData(id: "\($0.id ?? "")", paguthi_name: "\($0.paguthi_name ?? "")", full_name: "\($0.full_name ?? "")", mobile_no: "\($0.mobile_no ?? "")", created_by: "\($0.created_by ?? "")",door_no: "\($0.door_no ?? "")", address: "\($0.address ?? "")", father_husband_name: "\($0.father_husband_name ?? "")", office_name: "\($0.office_name ?? "")",pin_code: "\($0.pin_code ?? "")", dob: "\($0.dob ?? "")", meeting_date: "\($0.meeting_date ?? "")", meeting_status: "\($0.meeting_status ?? "")")
                     }
                    self.reportMeetingListView?.setReport(report: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.reportMeetingListView?.finishLoading()
                  self.reportMeetingListView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
