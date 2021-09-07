//
//  ReportConstituentListPresenter.swift
//  GMS Admin
//
//  Created by HappysanziMac on 06/09/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation
import UIKit

struct ReportConstituentListData {
    
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

protocol ReportConstituentListView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setFestival(reportConstituentList: [ReportConstituentListData])
    func setEmpty(errorMessage:String)
}

class ReportConstituentListPresenter: NSObject {
    
    private let reportConstituentListServiceService: ReportConstituentListService
    weak private var reportConstituentListServiceView : ReportConstituentListView?

    init(reportConstituentListServiceService:ReportConstituentListService) {
        self.reportConstituentListServiceService = reportConstituentListServiceService
    }
    
    func attachView(view:ReportConstituentListView) {
        reportConstituentListServiceView = view
    }
    
    func detachView() {
        reportConstituentListServiceView = nil
    }
    
    func getReportConstituentList(url: String, whatsap: String, emailId: String, voterId: String, paguthi: String,offset:String,rowCount:String,dob: String, phoneNum: String, keyword: String,dynamic_db:String,office:String) {
          self.reportConstituentListServiceView?.startLoading()
        reportConstituentListServiceService.callAPIReportConstituentList(
            url : url,whatsap: whatsap,emailId: emailId,voterId: voterId,paguthi: paguthi,offset: offset,rowCount: rowCount,dob: phoneNum,phoneNum: dob,keyword:keyword,dynamic_db:dynamic_db,office:office, onSuccess: { (meettingAll) in
            self.reportConstituentListServiceView?.finishLoading()
                if (meettingAll.count == 0){
                } else {
                   
                  let mappedUsers = meettingAll.map {
                    return ReportConstituentListData(email_id: "\($0.email_id ?? "")", full_name: "\($0.full_name ?? "")", dob: "\($0.dob ?? "")", mobile_no: "\($0.mobile_no ?? "")",door_no: "\($0.door_no ?? "")", address: "\($0.address ?? "")", pin_code: "\($0.pin_code ?? "")", father_husband_name: "\($0.created_at ?? "")", created_at: "\($0.created_at ?? "")")
                     }
                    self.reportConstituentListServiceView?.setFestival(reportConstituentList: mappedUsers)
                }
              },
              onFailure: { (errorMessage) in
                  self.reportConstituentListServiceView?.finishLoading()
                  self.reportConstituentListServiceView?.setEmpty(errorMessage: errorMessage)
              }
          )
      }
}
