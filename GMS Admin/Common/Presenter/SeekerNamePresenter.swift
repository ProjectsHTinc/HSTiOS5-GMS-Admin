//
//  SeekerNamePresenter.swift
//  GMS Admin
//
//  Created by HappysanziMac on 03/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import Foundation
import UIKit

struct SeekerTypeData {
    
    var id: String
    var seeker_info: String
    var status : String
    var created_by : String
    var created_at : String
    var updated_by : String
    var updated_at : String
}

protocol SeekerTypeView: NSObjectProtocol {
    func startLoadingSubCategoery()
    func finishLoadingSubCategoery()
    func setSeeker(subCategoery: [SeekerTypeData])
    func setEmptySubCategoery(errorMessage:String)
}

class SeekerTypePresenter: NSObject {
    
    private let seekerTypeService: SeekerTypeService
    weak private var seekerTypeView : SeekerTypeView?

    init(seekerTypeService:SeekerTypeService) {
        self.seekerTypeService = seekerTypeService
    }
    
    func attachView(view:SeekerTypeView) {
        seekerTypeView = view
    }
    
    func detachView() {
        seekerTypeView = nil
    }
    
    func getSeekerType(user_id : String,dynamic_db:String) {
          self.seekerTypeView?.startLoadingSubCategoery()
        seekerTypeService.callAPIseekerType(
            user_id : user_id,dynamic_db:dynamic_db, onSuccess: { (subCate) in
            self.seekerTypeView?.finishLoadingSubCategoery()
                if (subCate.count == 0){
                } else {
                  let mappedUsers = subCate.map {
                    return SeekerTypeData(id: "\($0.id ?? "")",seeker_info: "\($0.seeker_info ?? "")", status: "\($0.status ?? "")", created_by: "\($0.created_by ?? "")" ,created_at: "\($0.created_at ?? "")", updated_by: "\($0.updated_by ?? "")", updated_at: "\($0.updated_at ?? "")")
                     }
                    self.seekerTypeView?.setSeeker(subCategoery: mappedUsers)
                }
              },
              onFailure: { (errorMessage) in
                  self.seekerTypeView?.finishLoadingSubCategoery()
                  self.seekerTypeView?.setEmptySubCategoery(errorMessage: errorMessage)

              }
          )
      }

}
