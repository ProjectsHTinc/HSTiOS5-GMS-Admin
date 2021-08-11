//
//  StaffDetailPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct StaffDetailData {
    let full_name : String
    let phone_number : String
    let email_id : String
    let profile_pic : String
    let status : String
    let paguthi_name : String
    let role_name : String
    let gender : String
    let address : String
}

protocol StaffDetailView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setStaffDetail(staffdetail: [StaffDetailData])
    func setEmpty(errorMessage:String)
}

class StaffDetailPresenter: NSObject {
    
    private let staffDetailService: StaffDetailService
    weak private var staffDetailView : StaffDetailView?

    init(staffDetailService:StaffDetailService) {
        self.staffDetailService = staffDetailService
    }
    
    func attachView(view:StaffDetailView) {
        staffDetailView = view
    }
    
    func detachView() {
        staffDetailView = nil
    }
    
    func getStaffDetail(staff_id : String,dynamic_db:String) {
          self.staffDetailView?.startLoading()
          staffDetailService.callAPIStaffDetail(
            staff_id: staff_id,dynamic_db:dynamic_db, onSuccess: { (staffDetail) in
            self.staffDetailView?.finishLoading()
                if (staffDetail.count == 0){
                } else {
                  let mappedUsers = staffDetail.map {
                    return StaffDetailData(full_name: "\($0.full_name ?? "")", phone_number: "\($0.phone_number ?? "")", email_id: "\($0.email_id ?? "")", profile_pic: "\($0.profile_pic ?? "")", status: "\($0.status ?? "")", paguthi_name: "\($0.paguthi_name ?? "")", role_name: "\($0.role_name ?? "")", gender: "\($0.gender ?? "")", address: "\($0.address ?? "")")
                     }
                    self.staffDetailView?.setStaffDetail(staffdetail: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.staffDetailView?.finishLoading()
                  self.staffDetailView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
