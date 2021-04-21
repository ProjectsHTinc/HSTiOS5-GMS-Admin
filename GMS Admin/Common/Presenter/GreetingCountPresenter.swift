//
//  GreetingCountPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct GreetingCountData {
    
    var festival_name: String?
    var festival_wish_cnt: String?
    var festival_wishes_percentage : String?
  
}

protocol GreetingCountView : NSObjectProtocol {
    func startLoadingCi()
    func finishLoadingCI()
    func setCI(greetingCountData:[GreetingCountData])
    func setEmptyCI(errorMessage:String)
}

class GreetingCountPresenter: NSObject {
    
    private let greetingCountService:GreetingCountService
    weak private var greetingCountView : GreetingCountView?
    
    init(greetingCountService:GreetingCountService) {
        self.greetingCountService = greetingCountService
    }
    
    func attachView(view:GreetingCountView) {
        greetingCountView = view
    }
    
    func detachView() {
        greetingCountView = nil
    }
    
    func getGreetingCount(paguthi:String,from_date:String,to_date:String) {
        self.greetingCountView?.startLoadingCi()
        greetingCountService.callAPIGreetingCount(paguthi: paguthi, from_date: from_date, to_date: to_date, onSuccess: { (ci) in
                self.greetingCountView?.finishLoadingCI()
                if (ci.count == 0){
                } else {
                    let mappedUsers = ci.map {
                        return GreetingCountData(festival_name: "\($0.festival_name ?? "")", festival_wish_cnt: "\($0.festival_wish_cnt ?? "")", festival_wishes_percentage: "\($0.festival_wishes_percentage ?? "")")
                                                     
                    }
                    self.greetingCountView?.setCI(greetingCountData: mappedUsers)

                }
            },
            onFailure: { (errorMessage) in
                self.greetingCountView?.startLoadingCi()
                self.greetingCountView?.setEmptyCI(errorMessage: errorMessage)

            }
        )
    }

}
