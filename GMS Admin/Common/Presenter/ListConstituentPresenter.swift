//
//  ListConstituentPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 13/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ListConstituencyData {
    let full_name: String
    let mobile_no: String
    let serial_no: String
    let profile_pic: String
    let id: String

}

protocol ListConstituencyView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setConstituent(constituentname: [ListConstituencyData])
    func setEmptyListConstituency(errorMessage:String)
}

class ListConstituentPresenter: NSObject {
    
    private let listConstituentservice:ListConstituentservice
    weak private var listConstituencyView : ListConstituencyView?
    
    init(listConstituentservice:ListConstituentservice) {
        self.listConstituentservice = listConstituentservice
    }
    
    func attachView(view:ListConstituencyView) {
        listConstituencyView = view
    }
    
    func detachView() {
        listConstituencyView = nil
    }
    
    func getconstituencyList(url:String,Keyword:String,paguthi:String,offset:String, rowcount:String,dynamic_db:String) {
        self.listConstituencyView?.startLoading()
        listConstituentservice.callAPIConstituentList(
            url: url,Keyword: Keyword, paguthi: paguthi,offset:offset, rowcount: offset, dynamic_db: dynamic_db, onSuccess: { (constituentName) in
                self.listConstituencyView?.finishLoading()
                if (constituentName.count == 0){
                } else {
                    let mappedUsers = constituentName.map {
                        return ListConstituencyData(full_name: "\($0.full_name ?? "")", mobile_no: "\($0.mobile_no ?? "")", serial_no: "\($0.serial_no ?? "")", profile_pic: "\($0.profile_pic ?? "")", id: "\($0.id ?? "")")
                    }
                    self.listConstituencyView?.setConstituent(constituentname: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.listConstituencyView?.finishLoading()
                self.listConstituencyView?.setEmptyListConstituency(errorMessage: errorMessage)

            }
        )
    }

}
