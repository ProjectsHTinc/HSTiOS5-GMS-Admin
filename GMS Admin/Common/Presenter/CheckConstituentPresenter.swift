//
//  CheckConstituentPresenter.swift
//  GMS Admin
//
//  Created by HappysanziMac on 19/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

struct CheckConstituentData {
    
    var consituency_code : String?
    var constituency_name : String?
    var contact_person: String?
    var email_id: String?
    var mobile: String?
    var party_name: String?
    var msg: String?
   
}

protocol CheckConstituentView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setConstituency(constituencyname: [CheckConstituentData])
    //func setEmpty(errorMessage:String)
}

class CheckConstituentPresenter {
    
    private let checkConstituentService:CheckConstituentService
    weak private var checkConstituentView : CheckConstituentView?

   init(checkConstituentService:CheckConstituentService) {
      self.checkConstituentService = checkConstituentService
   }

   func attachView(view:CheckConstituentView) {
      checkConstituentView = view
   }

  func detachViewClientUrl() {
      checkConstituentView = nil
  }
    
    func getLoginData(constituency_code:String) {
        
        self.checkConstituentView?.startLoading()
        checkConstituentService.callAPIcheckConstituent(
            constituency_code: constituency_code, onSuccess: { (constituencyName) in
                self.checkConstituentView?.finishLoading()
                if (constituencyName.count == 0){
                } else {
                    let mappedUsers = constituencyName.map {
                        return CheckConstituentData(consituency_code: "\($0.consituency_code ?? "")", constituency_name: $0.constituency_name!,contact_person: "\($0.contact_person ?? "")", email_id: $0.email_id!,mobile: "\($0.mobile ?? "")", party_name: $0.party_name!)
                    }
                    self.checkConstituentView?.setConstituency(constituencyname: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.checkConstituentView?.finishLoading()
                //self.constituentView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }

}
