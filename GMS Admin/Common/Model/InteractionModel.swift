//
//  InteractionModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class InteractionModel {
    
     var interaction_question: String?
     var interaction_text: String?
     var status : String?


     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
          if let data = dict["interaction_question"] as? String {
             self.interaction_question = data
          }
        
          if let data = dict["interaction_text"] as? String {
             self.interaction_text = data
          }
        
          if let data = dict["status"] as? String {
             self.status = data
          }

    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> InteractionModel {
        let interactionModel = InteractionModel()
        interactionModel.loadFromDictionary(dict)
        return interactionModel
    }

}
