//
//  FestivalListPresenter.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

struct ReportFestivalListData {
    
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

protocol ReportFestivalListView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setReportFestivalList(reportFestivalList: [ReportFestivalListData])
    func setEmpty(errorMessage:String)
}

class ReportFestivalListPresenter: NSObject {
    
    private let reportFestivalListService: ReportFestivalListService
    weak private var reportFestivalListView : ReportFestivalListView?

    init(reportFestivalListService:ReportFestivalListService) {
        self.reportFestivalListService = reportFestivalListService
    }
    
    func attachView(view:ReportFestivalListView) {
        reportFestivalListView = view
    }
    
    func detachView() {
        reportFestivalListView = nil
    }
    
    func getReportFestivalList(url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String) {
          self.reportFestivalListView?.startLoading()
        reportFestivalListService.callAPIReportFestivalList(
            url : url,From: From,from_date: from_date,to_date: to_date,status: status,paguthi: paguthi,offset: offset,rowcount: rowcount,category: category,sub_category: sub_category,keyword: keyword,dynamic_db:dynamic_db,office:office, onSuccess: { (meettingAll) in
            self.reportFestivalListView?.finishLoading()
                if (meettingAll.count == 0){
                } else {
                  let mappedUsers = meettingAll.map {
                    return ReportFestivalListData(email_id: "\($0.email_id ?? "")", full_name: "\($0.full_name ?? "")", dob: "\($0.dob ?? "")", mobile_no: "\($0.mobile_no ?? "")", door_no: "\($0.door_no ?? "")", address: "\($0.address ?? "")", pin_code: "\($0.pin_code ?? "")", father_husband_name: "\($0.father_husband_name ?? "")",send_on: "\($0.send_on ?? "")")
                     }
                    self.reportFestivalListView?.setReportFestivalList(reportFestivalList: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.reportFestivalListView?.finishLoading()
                  self.reportFestivalListView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
