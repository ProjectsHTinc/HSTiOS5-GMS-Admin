//
//  VolounteerCountP{resenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct VolounteerData {
    var total_volunteer: String?
    var no_of_volunteer: String?
    var volunteer_percentage : String?
    var no_of_nonvolunteer : String?
    var nonvolunteer_percentage : String?

}

protocol VolounteerView : NSObjectProtocol {
    func startLoadingTm()
    func finishLoadingTm()
    func setTm(total_volunteer: String?, no_of_volunteer:String?, volunteer_percentage:String?,nonvolunteer_percentage: String?,no_of_nonvolunteer : String?)
    func setEmptyTm(errorMessage:String)
}

class VolounteerPresenter: NSObject {
    
    private let volounteerService:VolounteerService
    weak private var volounteerView : VolounteerView?
    
    init(volounteerService:VolounteerService) {
        self.volounteerService = volounteerService
    }
    
    func attachView(view:VolounteerView) {
        volounteerView = view
    }
    
    func detachView() {
        volounteerView = nil
    }
    
    func getVolounteer(paguthi:String,from_date:String,to_date:String) {
        self.volounteerView?.startLoadingTm()
        volounteerService.callAPIVolounteer(
            paguthi: paguthi,from_date:from_date, to_date:to_date, onSuccess: { (tm) in
                self.volounteerView?.finishLoadingTm()
                self.volounteerView?.setTm(total_volunteer: tm.total_volunteer, no_of_volunteer: tm.no_of_volunteer, volunteer_percentage: tm.volunteer_percentage, nonvolunteer_percentage: tm.nonvolunteer_percentage, no_of_nonvolunteer: tm.no_of_nonvolunteer)
            },
            onFailure: { (errorMessage) in
                self.volounteerView?.finishLoadingTm()
                self.volounteerView?.setEmptyTm(errorMessage: errorMessage)

            }
        )
    }

}
