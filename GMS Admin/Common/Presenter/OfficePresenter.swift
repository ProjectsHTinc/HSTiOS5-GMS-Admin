//
//  OfficePresenter.swift
//  GMS Admin
//
//  Created by HappysanziMac on 29/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

struct OfficeData {
    var id: String?
    var office_name : String?
    var office_short_form : String?
    var status : String?
    var paguthi_id : String?
    var updated_at : String?
    var updated_by : String?
}

protocol OfficeView : NSObjectProtocol {
         func startLoading()
         func finishLoading()
         func setoffice(office: [OfficeData])
         func setEmpty(errorMessage:String)
}

class OfficePresenter {
    
      private let officeService:OfficeService
      weak private var officeView : OfficeView?
      
      init(officeService:OfficeService) {
          self.officeService = officeService
      }
      
      func attachView(view:OfficeView) {
        officeView = view
      }
      
      func detachView() {
        officeView = nil
      }
      
    func getOffice(constituency_id:String,dynamic_db:String) {
          
          self.officeView?.startLoading()
        officeService.callAPIOffice(
            constituency_id: constituency_id,dynamic_db:dynamic_db, onSuccess: { (office) in
                  self.officeView?.finishLoading()
                  if (office.count == 0){
                  } else {
                      let mappedUsers = office.map {
                        return OfficeData(id: "\($0.id ?? "")", office_name: "\($0.office_name ?? "")")
                      }
                      self.officeView?.setoffice(office: mappedUsers)
                  }
              },
              onFailure: { (errorMessage) in
                  self.officeView?.finishLoading()
                  self.officeView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
