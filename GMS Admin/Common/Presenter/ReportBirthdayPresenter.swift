//
//  ReportBirthdayPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ReportBirthdayData {
    var email_id: String?
    var full_name: String?
    var dob : String?
    var mobile_no : String?
    var door_no : String?
    var address : String?
    var pin_code : String?
    var father_husband_name : String?
    var send_on : String?
}

protocol ReportBirthdayView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setReportBirthday(reportbday: [ReportBirthdayData])
    func setEmpty(errorMessage:String)
}

class ReportBirthdayPresenter: NSObject {
    
    private let reportBirthDayService: ReportBirthDayService
    weak private var reportBirthdayView : ReportBirthdayView?

    init(reportBirthDayService:ReportBirthDayService) {
        self.reportBirthDayService = reportBirthDayService
    }
    
    func attachView(view:ReportBirthdayView) {
        reportBirthdayView = view
    }
    
    func detachView() {
        reportBirthdayView = nil
    }
    
    func getReportBirthday(url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String) {
          self.reportBirthdayView?.startLoading()
          reportBirthDayService.callAPIReportBirthday(
            url : url,From: From,from_date: from_date,to_date: to_date,status: status,paguthi: paguthi,offset: offset,rowcount: rowcount,category: category,sub_category: sub_category,keyword: keyword,dynamic_db:dynamic_db,office:office, onSuccess: { (meettingAll) in
            self.reportBirthdayView?.finishLoading()
                if (meettingAll.count == 0){
                } else {
                  let mappedUsers = meettingAll.map {
                    return ReportBirthdayData(email_id: "\($0.email_id ?? "")", full_name: "\($0.full_name ?? "")", dob: "\($0.dob ?? "")", mobile_no: "\($0.mobile_no ?? "")", door_no: "\($0.door_no ?? "")", address: "\($0.address ?? "")", pin_code: "\($0.pin_code ?? "")", father_husband_name: "\($0.father_husband_name ?? "")",send_on: "\($0.send_on ?? "")")
                     }
                    self.reportBirthdayView?.setReportBirthday(reportbday: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.reportBirthdayView?.finishLoading()
                  self.reportBirthdayView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
