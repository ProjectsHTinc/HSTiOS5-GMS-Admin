//
//  SearchModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 07/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class SearchModel {

      var id: String?
      var full_name: String?
      var mobile_no : String?
      var profile_pic : String?
      var paguthi_name : String?
      var serial_no : String?

      // MARK: Instance Method
      func loadFromDictionary(_ dict: [String: AnyObject])
      {
          if let data = dict["id"] as? String {
              self.id = data
          }
          if let data = dict["full_name"] as? String {
              self.full_name = data
          }
          if let data = dict["mobile_no"] as? String {
              self.mobile_no = data
          }
          if let data = dict["profile_pic"] as? String {
              self.profile_pic = data
          }
          if let data = dict["paguthi_name"] as? String {
              self.paguthi_name = data
          }
          if let data = dict["serial_no"] as? String {
            self.serial_no = data
          }
      }
      
      // MARK: Class Method
      class func build(_ dict: [String: AnyObject]) -> SearchModel {
          let searchModel = SearchModel()
          searchModel.loadFromDictionary(dict)
          return searchModel
      }
}
