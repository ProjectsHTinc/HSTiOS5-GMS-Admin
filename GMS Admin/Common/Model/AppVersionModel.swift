//
//  AppVersionModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class AppVersionModel {
      
     var msg : String?
     var status : String?
    
      // MARK: Instance Method
      func loadFromDictionary(_ dict: [String: AnyObject])
      {
          if let data = dict["msg"] as? String {
              self.msg = data
          }

         if let data = dict["status"] as? String {
             self.status = data
         }
      }
      
      // MARK: Class Method
      class func build(_ dict: [String: AnyObject]) -> AppVersionModel {
          let appVersionModel = AppVersionModel()
          appVersionModel.loadFromDictionary(dict)
          return appVersionModel
      }
}
