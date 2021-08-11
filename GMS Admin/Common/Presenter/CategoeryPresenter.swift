//
//  CategoeryPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct CategoeryData {
    let id : String
    let seeker_id : String
    let grievance_name : String
    let status : String
    let created_by : String
    let created_at : String
    let updated_by : String
    let updated_at : String

}

protocol CategoeryView: NSObjectProtocol {
    func startLoadingCategoery()
    func finishLoadingCategoery()
    func setCategoery(categoery: [CategoeryData])
    func setEmptyCategoery(errorMessage:String)
}

class CategoeryPresenter: NSObject {

    private let categoeryService: CategoeryService
    weak private var categoeryView : CategoeryView?

    init(categoeryService:CategoeryService) {
        self.categoeryService = categoeryService
    }
    
    func attachView(view:CategoeryView) {
        categoeryView = view
    }
    
    func detachView() {
        categoeryView = nil
    }

    func getCategoery(user_id : String,dynamic_db:String) {
          self.categoeryView?.startLoadingCategoery()
          categoeryService.callAPICategoery(
            user_id : user_id,dynamic_db:dynamic_db, onSuccess: { (cate) in
            self.categoeryView?.finishLoadingCategoery()
                if (cate.count == 0){
                } else {
                  let mappedUsers = cate.map {
                    return CategoeryData(id: "\($0.id ?? "")", seeker_id: "\($0.seeker_id ?? "")", grievance_name: "\($0.grievance_name ?? "")", status: "\($0.status ?? "")", created_by: "\($0.created_by ?? "")", created_at: "\($0.created_at ?? "")", updated_by: "\($0.updated_by ?? "")", updated_at: "\($0.updated_at ?? "")")
                     }
                    self.categoeryView?.setCategoery(categoery: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.categoeryView?.finishLoadingCategoery()
                  self.categoeryView?.setEmptyCategoery(errorMessage: errorMessage)

              }
          )
      }
}
