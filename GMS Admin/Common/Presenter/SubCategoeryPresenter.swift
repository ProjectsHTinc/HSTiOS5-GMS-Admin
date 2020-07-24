//
//  SubCategoeryPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct SubCategoeryData {
    let id : String
    let grievance_id : String
    let sub_category_name : String
    let status : String
    let created_by : String
    let created_at : String
    let updated_by : String
    let updated_at : String
}

protocol SubCategoeryView: NSObjectProtocol {
    func startLoadingSubCategoery()
    func finishLoadingSubCategoery()
    func setSubCategoery(subCategoery: [SubCategoeryData])
    func setEmptySubCategoery(errorMessage:String)
}

class SubCategoeryPresenter: NSObject {
    
    private let subCategoeryService: SubCategoeryService
    weak private var subCategoeryView : SubCategoeryView?

    init(subCategoeryService:SubCategoeryService) {
        self.subCategoeryService = subCategoeryService
    }
    
    func attachView(view:SubCategoeryView) {
        subCategoeryView = view
    }
    
    func detachView() {
        subCategoeryView = nil
    }
    
    func getSubCate(user_id : String) {
          self.subCategoeryView?.startLoadingSubCategoery()
          subCategoeryService.callAPISubCategoery(
            user_id : user_id, onSuccess: { (subCate) in
            self.subCategoeryView?.finishLoadingSubCategoery()
                if (subCate.count == 0){
                } else {
                  let mappedUsers = subCate.map {
                    return SubCategoeryData(id: "\($0.id ?? "")", grievance_id: "\($0.grievance_id ?? "")", sub_category_name: "\($0.sub_category_name ?? "")", status: "\($0.status ?? "")", created_by: "\($0.created_by ?? "")", created_at: "\($0.created_at ?? "")", updated_by: "\($0.updated_by ?? "")", updated_at: "\($0.updated_at ?? "")")
                     }
                    self.subCategoeryView?.setSubCategoery(subCategoery: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.subCategoeryView?.finishLoadingSubCategoery()
                  self.subCategoeryView?.setEmptySubCategoery(errorMessage: errorMessage)

              }
          )
      }

}
