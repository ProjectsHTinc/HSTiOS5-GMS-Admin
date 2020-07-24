//
//  ConstituencyPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 27/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct constituencyData {
    let constituency_name: String
    let constituency_id: Int
}

protocol ConstituentView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setConstituency(constituencyname: [constituencyData])
    //func setEmpty(errorMessage:String)
}

class ConstituencyPresenter {
    
    private let constituencyService:ConstituencyService
    weak private var constituentView : ConstituentView?
    
    init(constituencyService:ConstituencyService) {
        self.constituencyService = constituencyService
    }
    
    func attachView(view:ConstituentView) {
        constituentView = view
    }
    
    func detachView() {
        constituentView = nil
    }
    
    func getconstituencyList(partyID:String) {
        
        self.constituentView?.startLoading()
        constituencyService.callAPIGetConstituencyList(
            partyID: partyID, onSuccess: { (constituencyName) in
                self.constituentView?.finishLoading()
                if (constituencyName.count == 0){
                } else {
                    let mappedUsers = constituencyName.map {
                        return constituencyData(constituency_name: "\($0.constituency_name ?? "")", constituency_id: $0.constituency_id!)
                    }
                    self.constituentView?.setConstituency(constituencyname: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.constituentView?.finishLoading()
                //self.constituentView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }

}
