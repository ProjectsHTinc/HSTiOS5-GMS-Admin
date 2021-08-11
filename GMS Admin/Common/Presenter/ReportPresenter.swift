//
//  ReportPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ReportData {
    let id : String
    let paguthi_name : String
    let petition_enquiry_no : String
    let grievance_date : String
    let status : String
    let full_name : String
    let mobile_no : String
    let created_by : String
    let grievance_name : String
    let role_name : String
    let grievance_type : String?
    var address : String?
    var father_husband_name : String?
    var office_name : String?
    var pin_code : String?
    var dob : String?
}

protocol ReportView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setReport(report: [ReportData])
    func setEmpty(errorMessage:String)
}

class ReportPresenter: NSObject {
    
    private let reportService: ReportService
    weak private var reportView : ReportView?

    init(reportService:ReportService) {
        self.reportService = reportService
    }
    
    func attachView(view:ReportView) {
        reportView = view
    }
    
    func detachView() {
        reportView = nil
    }
    
    func getReport(url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String) {
          self.reportView?.startLoading()
          reportService.callAPIStaffReport(
            url : url,From: From,from_date: from_date,to_date: to_date,status: status,paguthi: paguthi,offset: offset,rowcount: rowcount,category: category,sub_category: sub_category,keyword: keyword,dynamic_db:dynamic_db,office:office, onSuccess: { (report) in
            self.reportView?.finishLoading()
                if (report.count == 0){
                } else {
                  let mappedUsers = report.map {
                    return ReportData(id: "\($0.id ?? "")", paguthi_name: "\($0.paguthi_name ?? "")", petition_enquiry_no: "\($0.petition_enquiry_no ?? "")", grievance_date: "\($0.grievance_date ?? "")", status: "\($0.status ?? "")", full_name: "\($0.full_name ?? "")", mobile_no: "\($0.mobile_no ?? "")", created_by: "\($0.created_by ?? "")", grievance_name: "\($0.grievance_name ?? "")", role_name: "\($0.role_name ?? "")", grievance_type: "\($0.grievance_type ?? "")", address: "\($0.address ?? "")", father_husband_name: "\($0.father_husband_name ?? "")", office_name: "\($0.office_name ?? "")", pin_code: "\($0.pin_code ?? "")", dob: "\($0.dob ?? "")")
                     }
                    self.reportView?.setReport(report: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.reportView?.finishLoading()
                  self.reportView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
