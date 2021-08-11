//
//  ConstituentGreivancesMessagePresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 21/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ConstituentGreivancesMessageData {
    let id : String
    let sms_text : String
    let created_at : String
    let created_by : String
}

protocol ConstituentGreivancesMessageView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setConsGrieMessage(ConsGriMessage: [ConstituentGreivancesMessageData])
    func setEmpty(errorMessage:String)
}

class ConstituentGreivancesMessagePresenter: NSObject {
    
    private let constituentGreivancesMessageService: ConstituentGreivancesMessageService
    weak private var constituentGreivancesMessageView : ConstituentGreivancesMessageView?

    init(constituentGreivancesMessageService:ConstituentGreivancesMessageService) {
        self.constituentGreivancesMessageService = constituentGreivancesMessageService
    }
    
    func attachView(view:ConstituentGreivancesMessageView) {
        constituentGreivancesMessageView = view
    }
    
    func detachView() {
        constituentGreivancesMessageView = nil
    }
    
    func getConsGrieMessage(grievance_id:String,dynamic_db:String) {
          self.constituentGreivancesMessageView?.startLoading()
          constituentGreivancesMessageService.callAPIConstituentGreivancesMeeting(
            grievance_id: grievance_id,dynamic_db:dynamic_db, onSuccess: { (plant) in
            self.constituentGreivancesMessageView?.finishLoading()
                if (plant.count == 0){
                } else {
                  let mappedUsers = plant.map {
                    return ConstituentGreivancesMessageData(id: "\($0.id ?? "")", sms_text: "\($0.sms_text ?? "")", created_at: "\($0.created_at ?? "")", created_by: "\($0.created_by ?? "")")
                     }
                    self.constituentGreivancesMessageView?.setConsGrieMessage(ConsGriMessage: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.constituentGreivancesMessageView?.finishLoading()
                  self.constituentGreivancesMessageView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
