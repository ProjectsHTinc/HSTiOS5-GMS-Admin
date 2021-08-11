//
//  ReportVideoListPresenter.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation

import UIKit

struct ReportVideoListData {
    
    var email_id: String?
    var full_name: String?
    var dob : String?
    var mobile_no : String?
    var door_no : String?
    var address : String?
    var pin_code : String?
    var father_husband_name : String?
    var created_at : String?
}

protocol ReportVideoListView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setReportVideoList(reportVideoList: [ReportVideoListData])
    func setEmpty(errorMessage:String)
}

class ReportVideoListPresenter: NSObject {
    
    private let reportVideoListService: ReportVideoListService
    weak private var reportVideoListView : ReportVideoListView?

    init(reportVideoListService:ReportVideoListService) {
        self.reportVideoListService = reportVideoListService
    }
    
    func attachView(view:ReportVideoListView) {
        reportVideoListView = view
    }
    
    func detachView() {
        reportVideoListView = nil
    }
    
    func getReportVideoList(url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String) {
          self.reportVideoListView?.startLoading()
        reportVideoListService.callAPIReportVideoList(
            url : url,From: From,from_date: from_date,to_date: to_date,status: status,paguthi: paguthi,offset: offset,rowcount: rowcount,category: category,sub_category: sub_category,keyword: keyword,dynamic_db:dynamic_db,office:office, onSuccess: { (meettingAll) in
            self.reportVideoListView?.finishLoading()
                if (meettingAll.count == 0){
                } else {
                  let mappedUsers = meettingAll.map {
                    return ReportVideoListData(email_id: "\($0.email_id ?? "")", full_name: "\($0.full_name ?? "")", dob: "\($0.dob ?? "")", mobile_no: "\($0.mobile_no ?? "")", door_no: "\($0.door_no ?? "")", address: "\($0.address ?? "")", pin_code: "\($0.pin_code ?? "")", father_husband_name: "\($0.father_husband_name ?? "")",created_at: "\($0.created_at ?? "")")
                     }
                    self.reportVideoListView?.setReportVideoList(reportVideoList: mappedUsers)
                }
              },
              onFailure: { (errorMessage) in
                  self.reportVideoListView?.finishLoading()
                  self.reportVideoListView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }
}
