//
//  BirthdayYearPresenter.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation
import UIKit

struct BirthdayYearData {
    
    var year_name: String
   
}

protocol BirthdayYearView: NSObjectProtocol {
    func startLoadingSubCategoery()
    func finishLoadingSubCategoery()
    func setBirthdayYear(birthdayYear: [BirthdayYearData])
    func setEmptySubCategoery(errorMessage:String)
}

class BirthdayYearPresenter: NSObject {
    
    private let birthdayYearService: BirthdayYearService
    weak private var birthdayYearView : BirthdayYearView?

    init(birthdayYearService:BirthdayYearService) {
        self.birthdayYearService = birthdayYearService
    }
    
    func attachView(view:BirthdayYearView) {
        birthdayYearView = view
    }
    
    func detachView() {
        birthdayYearView = nil
    }
    
    func getBirthdayYear(dynamic_db:String) {
          self.birthdayYearView?.startLoadingSubCategoery()
        birthdayYearService.callAPIBirthdayYear(
            dynamic_db:dynamic_db, onSuccess: { (birthdayYear) in
            self.birthdayYearView?.finishLoadingSubCategoery()
                if (birthdayYear.count == 0){
                } else {
                  let mappedUsers = birthdayYear.map {
                    return BirthdayYearData(year_name: "\($0.year_name ?? "")")
                     }
                    self.birthdayYearView?.setBirthdayYear(birthdayYear: mappedUsers)
                }
              },
              onFailure: { (errorMessage) in
                  self.birthdayYearView?.finishLoadingSubCategoery()
                self.birthdayYearView?.setEmptySubCategoery(errorMessage: errorMessage)

              }
          )
      }

}
