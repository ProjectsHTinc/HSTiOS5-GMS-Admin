//
//  ConstituentDetailPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 13/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ConstituentDetailData:Codable {
    let full_name: String?
    let mobile_no: String?
    let address: String?
    let ward_id: String?
    let voter_id_no: String?
    let id: String?
    let aadhaar_no: String?
    let profile_pic: String?
    let pin_code : String?
    let father_husband_name : String?
    let whatsapp_no : String?
    let email_id : String?
    let constituency_name : String?
    let paguthi_name : String?
    let ward_name : String?
    let booth_name : String?
    let dob : String?
    let gender : String?
    let religion_name : String?
    let booth_address : String?
    let serial_no : String?

}

protocol ConstituentDetailView : NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setConstituentDetailData(constituentDetail: [ConstituentDetailData])
    func setEmpty(errorMessage:String)
}

class ConstituentDetailPresenter: NSObject {
    
      private let constituentDetailService:ConstituentDetailService
      weak private var constituentDetailView : ConstituentDetailView?

     init(constituentDetailService:ConstituentDetailService) {
        self.constituentDetailService = constituentDetailService
     }

     func attachView(view:ConstituentDetailView) {
         constituentDetailView = view
     }

    func detachViewClientUrl() {
        constituentDetailView = nil
    }
    
    func getConstituentDetailData(constituent_id:String,dynamic_db:String) {
        self.constituentDetailView?.startLoading()
        constituentDetailService.callAPIConstituentDetail(
            constituent_id: constituent_id,dynamic_db:dynamic_db, onSuccess: { (constituentDetail) in
                self.constituentDetailView?.finishLoading()
                if (constituentDetail.count == 0){
                } else {
                    let mappedUsers = constituentDetail.map {
                        return ConstituentDetailData(full_name: "\($0.full_name ?? "")", mobile_no: "\($0.mobile_no ?? "")", address: "\($0.address ?? "")", ward_id: "\($0.ward_id ?? "")", voter_id_no: "\($0.voter_id_no ?? "")", id: "\($0.id ?? "")", aadhaar_no: "\($0.aadhaar_no ?? "")", profile_pic: "\($0.profile_pic ?? "")", pin_code: "\($0.pin_code ?? "")", father_husband_name: "\($0.father_husband_name ?? "")", whatsapp_no: "\($0.whatsapp_no  ?? "")", email_id: "\($0.email_id ?? "")", constituency_name: "\($0.constituency_name ?? "")", paguthi_name: "\($0.paguthi_name ?? "")", ward_name: "\($0.ward_name ?? "")", booth_name: "\($0.booth_name ?? "")", dob: "\($0.dob ?? "")", gender: "\($0.gender ?? "")", religion_name: "\($0.religion_name ?? "")",booth_address: "\($0.booth_address ?? "")",serial_no: "\($0.serial_no ?? "")")
                    }
                    self.constituentDetailView?.setConstituentDetailData(constituentDetail: mappedUsers)
                    UserDefaults.standard.setConsProfileInfo(mappedUsers, forKey: UserDefaultsKey.ConsProfilekey.rawValue)
                }
            },
            onFailure: { (errorMessage) in
                self.constituentDetailView?.setEmpty(errorMessage: errorMessage)
                self.constituentDetailView?.finishLoading()

            }
        )
    }

}
