//
//  StaffPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct staffData {
    let full_name : String
    let phone_number : String
    let email_id : String
    let profile_pic : String
    let status : String
    let paguthi_name : String
    let id : String
}

protocol StaffView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setStaff(staff: [staffData])
    func setEmpty(errorMessage:String)
}

class StaffPresenter: NSObject {

    private let staffService: StaffService
    weak private var staffView : StaffView?

    init(staffService:StaffService) {
        self.staffService = staffService
    }
    
    func attachView(view:StaffView) {
        staffView = view
    }
    
    func detachView() {
        staffView = nil
    }
    
    func getStaff(constituency_id : String,dynamic_db:String) {
          self.staffView?.startLoading()
          staffService.callAPIStaff(
            constituency_id: constituency_id, dynamic_db:dynamic_db,onSuccess: { (staff) in
            self.staffView?.finishLoading()
                if (staff.count == 0){
                } else {
                  let mappedUsers = staff.map {
                    return staffData(full_name: "\($0.full_name ?? "")", phone_number: "\($0.phone_number ?? "")", email_id: "\($0.email_id ?? "")", profile_pic: "\($0.profile_pic ?? "")", status: "\($0.status ?? "")", paguthi_name: "\($0.paguthi_name ?? "")", id: "\($0.id ?? "")")
                     }
                    self.staffView?.setStaff(staff: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.staffView?.finishLoading()
                  self.staffView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }
}
