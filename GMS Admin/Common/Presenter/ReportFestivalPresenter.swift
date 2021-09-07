//
//  ReportFestivalPresenter.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation
import UIKit

struct ReportFestivalData {
    
    var id: String?
    var festival_name : String?
    var religion_id : String?
    var status : String?

}

protocol ReportFestivalView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setFestival(reportFestivalData: [ReportFestivalData])
    func setEmpty(errorMessage:String)
}

class ReportFestivalPresenter: NSObject {
    
    private let reportFestivalService: ReportFestivalService
    weak private var reportFestivalView : ReportFestivalView?

    init(reportFestivalService:ReportFestivalService) {
        self.reportFestivalService = reportFestivalService
    }
    
    func attachView(view:ReportFestivalView) {
        reportFestivalView = view
    }
    
    func detachView() {
        reportFestivalView = nil
    }
    
    func getfestival(dynamic_db:String) {
          self.reportFestivalView?.startLoading()
        reportFestivalService.callAPIReportFestival(
            dynamic_db:dynamic_db, onSuccess: { (meettingAll) in
            self.reportFestivalView?.finishLoading()
                if (meettingAll.count == 0){
                } else {
                   
                  let mappedUsers = meettingAll.map {
                    return ReportFestivalData(id: "\($0.id ?? "")", festival_name: "\($0.festival_name ?? "")", religion_id: "\($0.religion_id ?? "")", status: "\($0.status ?? "")")
                     }
                    self.reportFestivalView?.setFestival(reportFestivalData: mappedUsers)
                }
              },
              onFailure: { (errorMessage) in
                  self.reportFestivalView?.finishLoading()
                  self.reportFestivalView?.setEmpty(errorMessage: errorMessage)
              }
          )
      }
}
