//
//  ReportVedioListPresenter.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation
import UIKit

struct ReportStaffListData {
    
    var full_name: String?
    var id: String?
    var total_broadcast : String?
    var total_cons : String?
    var total_g : String?
    var total_v : String?

}

protocol ReportStaffListView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setReportStaffList(reportStaffoList: [ReportStaffListData])
    func setEmpty(errorMessage:String)
}

class ReportStaffListPresenter: NSObject {
    
    private let reportStaffListService: ReportStaffListService
    weak private var reportStaffListView : ReportStaffListView?

    init(reportStaffListService:ReportStaffListService) {
        self.reportStaffListService = reportStaffListService
    }
    
    func attachView(view:ReportStaffListView) {
        reportStaffListView = view
    }
    
    func detachView() {
        reportStaffListView = nil
    }
    
    func getReportStaffList(url:String,from_date: String,to_date: String,dynamic_db:String) {
          self.reportStaffListView?.startLoading()
        reportStaffListService.callAPIReportStaffList(
            url:url,from_date: from_date,to_date: to_date,dynamic_db:dynamic_db, onSuccess: { (meettingAll) in
            self.reportStaffListView?.finishLoading()
                if (meettingAll.count == 0){
                } else {
                  let mappedUsers = meettingAll.map {
                    return ReportStaffListData(full_name: "\($0.full_name ?? "")", id: "\($0.id ?? "")", total_broadcast: "\($0.total_broadcast ?? "")", total_cons: "\($0.total_cons ?? "")", total_g: "\($0.total_g ?? "")", total_v: "\($0.total_v ?? "")")
                     }
                    self.reportStaffListView?.setReportStaffList(reportStaffoList: mappedUsers)
                }
              },
              onFailure: { (errorMessage) in
                  self.reportStaffListView?.finishLoading()
                  self.reportStaffListView?.setEmpty(errorMessage: errorMessage)
              }
          )
      }
}
