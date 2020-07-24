//
//  ReportStaffPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ReportStaffData {
    let id: String?
    let full_name: String?
    let total : String?
    let active : String?
    let inactive : String?
}

protocol ReportStaffView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setReportStaff(reportstaff: [ReportStaffData])
    func setEmpty(errorMessage:String)
}

class ReportStaffPresenter: NSObject {
    
    private let reportStaffService: ReportStaffService
    weak private var reportStaffView : ReportStaffView?

    init(reportStaffService:ReportStaffService) {
        self.reportStaffService = reportStaffService
    }
    
    func attachView(view:ReportStaffView) {
        reportStaffView = view
    }
    
    func detachView() {
        reportStaffView = nil
    }
    
    func getReportStaff(from_date:String, to_date:String) {
          self.reportStaffView?.startLoading()
          reportStaffService.callAPIReportStaff(
            from_date: from_date, to_date: to_date, onSuccess: { (meettingAll) in
            self.reportStaffView?.finishLoading()
                if (meettingAll.count == 0){
                } else {
                  let mappedUsers = meettingAll.map {
                    return ReportStaffData(id: "\($0.id ?? "")", full_name: "\($0.full_name ?? "")", total: "\($0.total ?? "")", active: "\($0.active ?? "")", inactive: "\($0.inactive ?? "")")
                     }
                    self.reportStaffView?.setReportStaff(reportstaff: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.reportStaffView?.finishLoading()
                  self.reportStaffView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
