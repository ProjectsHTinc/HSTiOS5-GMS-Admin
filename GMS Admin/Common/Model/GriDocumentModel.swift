//
//  GriDocumentModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class GriDocumentModel {
    
     var id: String?
     var doc_name: String?
     var doc_file_name : String?
     var created_at : String?


     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
          if let data = dict["id"] as? String {
             self.id = data
          }
        
          if let data = dict["doc_name"] as? String {
             self.doc_name = data
          }
        
          if let data = dict["doc_file_name"] as? String {
             self.doc_file_name = data
          }
        
         if let data = dict["created_at"] as? String {
            self.created_at = data
         }

    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> GriDocumentModel {
        let griDocumentModel = GriDocumentModel()
        griDocumentModel.loadFromDictionary(dict)
        return griDocumentModel
    }

}
