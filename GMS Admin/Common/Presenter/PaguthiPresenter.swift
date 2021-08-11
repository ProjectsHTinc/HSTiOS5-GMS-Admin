//
//  PaguthiPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 08/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct PaguthiData {
    let id : String
    let constituency_id : String
    let paguthi_name : String
}

protocol PaguthiView : NSObjectProtocol {
         func startLoading()
         func finishLoading()
         func setPaguthi(paguthi: [PaguthiData])
         func setEmpty(errorMessage:String)
}

class PaguthiPresenter {
    
      private let areaService:AreaService
      weak private var paguthiView : PaguthiView?
      
      init(areaService:AreaService) {
          self.areaService = areaService
      }
      
      func attachView(view:PaguthiView) {
          paguthiView = view
      }
      
      func detachView() {
          paguthiView = nil
      }
      
    func getPaguthi(constituency_id:String,dynamic_db:String) {
          
          self.paguthiView?.startLoading()
          areaService.callAPIPaguthi(
            constituency_id: constituency_id,dynamic_db:dynamic_db, onSuccess: { (paguthi) in
                  self.paguthiView?.finishLoading()
                  if (paguthi.count == 0){
                  } else {
                      let mappedUsers = paguthi.map {
                        return PaguthiData(id: "\($0.id ?? "")", constituency_id: "\($0.constituency_id ?? "")", paguthi_name: "\($0.paguthi_name ?? "")")
                      }
                      self.paguthiView?.setPaguthi(paguthi: mappedUsers)
                  }
              },
              onFailure: { (errorMessage) in
                  self.paguthiView?.finishLoading()
                  self.paguthiView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
