//
//  ReportGrievanceListPresenter.swift
//  GMS Admin
//
//  Created by HappysanziMac on 03/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation

import UIKit

struct ReportGrievanceListData {
    
    var id: String
    var door_no: String
    var petition_enquiry_no : String
    var grievance_date : String
    var status : String
    var full_name : String
    var mobile_no : String
    var created_by : String
    var grievance_name : String
    var grievance_type : String
    var address : String
    var father_husband_name : String
    var office_name : String
    var pin_code : String
    var dob : String

}

protocol ReportGrievanceListView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setReport(report: [ReportGrievanceListData])
    func setEmpty(errorMessage:String)
}

class ReportGrievanceListPresenter: NSObject {
    
    private let reportGrievanceListService: ReportGrievanceListService
    weak private var reportGrievanceListView : ReportGrievanceListView?

    init(reportGrievanceListService:ReportGrievanceListService) {
        self.reportGrievanceListService = reportGrievanceListService
    }
    
    func attachView(view:ReportGrievanceListView) {
        reportGrievanceListView = view
    }
    
    func detachView() {
        reportGrievanceListView = nil
    }
    
    func getGrievanceReportList(url : String,seeker_type_id: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String) {
          self.reportGrievanceListView?.startLoading()
        reportGrievanceListService.callAPIReportGrievanceList(
            url : url,seeker_type_id: seeker_type_id,from_date: from_date,to_date: to_date,status: status,paguthi: paguthi,offset: offset,rowcount: rowcount,category: category,sub_category: sub_category,keyword: keyword,dynamic_db:dynamic_db,office:office, onSuccess: { (report) in
            self.reportGrievanceListView?.finishLoading()
                if (report.count == 0){
                } else {
                  let mappedUsers = report.map {
                    return ReportGrievanceListData(id: "\($0.id ?? "")", door_no: "\($0.door_no ?? "")", petition_enquiry_no: "\($0.petition_enquiry_no ?? "")", grievance_date: "\($0.grievance_date ?? "")", status: "\($0.status ?? "")", full_name: "\($0.full_name ?? "")", mobile_no: "\($0.mobile_no ?? "")", created_by: "\($0.created_by ?? "")", grievance_name: "\($0.grievance_name ?? "")", grievance_type: "\($0.grievance_type ?? "")", address: "\($0.address ?? "")", father_husband_name: "\($0.father_husband_name ?? "")", office_name: "\($0.office_name ?? "")", pin_code: "\($0.pin_code ?? "")", dob: "\($0.dob ?? "")")
                     }
                    self.reportGrievanceListView?.setReport(report: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.reportGrievanceListView?.finishLoading()
                  self.reportGrievanceListView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
