//
//  ConstituentinterActionPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ConstituentinterActionData {
    let question_id : String?
    let widgets_title: String?
    let tot_values: String?

}

protocol ConstituentinterActionView : NSObjectProtocol {
    func startLoadingCi()
    func finishLoadingCI()
    func setCI(consituentInteraction:[ConstituentinterActionData])
    func setEmptyCI(errorMessage:String)
}

class ConstituentinterActionPresenter: NSObject {
    
    private let constituentInteractionService:ConstituentInteractionService
    weak private var constituentinterActionView : ConstituentinterActionView?
    
    init(constituentInteractionService:ConstituentInteractionService) {
        self.constituentInteractionService = constituentInteractionService
    }
    
    func attachView(view:ConstituentinterActionView) {
        constituentinterActionView = view
    }
    
    func detachView() {
        constituentinterActionView = nil
    }
    
    func getTotalGreviances(paguthi:String) {
        self.constituentinterActionView?.startLoadingCi()
        constituentInteractionService.callAPIConstituentIneraction(
            paguthi: paguthi, onSuccess: { (ci) in
                self.constituentinterActionView?.finishLoadingCI()
                if (ci.count == 0){
                } else {
                    let mappedUsers = ci.map {
                        return ConstituentinterActionData(question_id: "\($0.question_id ?? "")", widgets_title: "\($0.widgets_title ?? "")", tot_values: "\($0.tot_values ?? "")")
                    }
                    self.constituentinterActionView?.setCI(consituentInteraction: mappedUsers)

                }
            },
            onFailure: { (errorMessage) in
                self.constituentinterActionView?.startLoadingCi()
                self.constituentinterActionView?.setEmptyCI(errorMessage: errorMessage)

            }
        )
    }

}
