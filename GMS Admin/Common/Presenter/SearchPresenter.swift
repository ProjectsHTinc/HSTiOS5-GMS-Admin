//
//  SearchPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 07/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct searchData {
    let id : String
    let full_name: String
    let mobile_no: String
    let profile_pic: String
    let serial_no: String
}

protocol SearchView : NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setValues(search: [searchData])
    func setEmpty(errorMessage:String)
}

class SearchPresenter {

      private let searchService:SearchService
      weak private var searchView : SearchView?
      
      init(searchService:SearchService) {
          self.searchService = searchService
      }
      
      func attachView(view:SearchView) {
           searchView = view
      }
      
      func detachView() {
           searchView = nil
      }
      
      func getSearch(keyword:String, offset:String, rowcount:String) {
          self.searchView?.startLoading()
          searchService.callAPISearch(
              keyword: keyword, offset: offset, rowcount: rowcount, onSuccess: { (search) in
                  self.searchView?.finishLoading()
                  if (search.count == 0){
                  } else {
                      let mappedUsers = search.map {
                        return searchData(id: "\($0.id ?? "")", full_name: "\($0.full_name ?? "")", mobile_no: "\($0.mobile_no ?? "")", profile_pic: "\($0.profile_pic ?? "")", serial_no: "\($0.serial_no ?? "")")
                      }
                      self.searchView?.setValues(search: mappedUsers)
                  }
              },
              onFailure: { (errorMessage) in
                  self.searchView?.finishLoading()
                  self.searchView?.setEmpty(errorMessage: errorMessage)
              }
          )
      }
}
