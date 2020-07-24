//
//  ReportBirthdayPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ReportBirthdayData {
    let const_id: String?
    let full_name: String?
    let dob : String?
    let mobile_no : String?
    let door_no : String?
    let address : String?
    let pin_code : String?
    let birth_wish_status : String?
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
    
    func getReportBirthday(url:String, select_month : String, keyword: String, offset:String, rowcount:String) {
          self.reportBirthdayView?.startLoading()
          reportBirthDayService.callAPIReportBirthday(
            url: url, select_month: select_month, keyword: keyword, offset: offset, rowcount: rowcount, onSuccess: { (meettingAll) in
            self.reportBirthdayView?.finishLoading()
                if (meettingAll.count == 0){
                } else {
                  let mappedUsers = meettingAll.map {
                    return ReportBirthdayData(const_id: "\($0.const_id ?? "")", full_name: "\($0.full_name ?? "")", dob: "\($0.dob ?? "")", mobile_no: "\($0.mobile_no ?? "")", door_no: "\($0.door_no ?? "")", address: "\($0.address ?? "")", pin_code: "\($0.pin_code ?? "")", birth_wish_status: "\($0.birth_wish_status ?? "")")
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
