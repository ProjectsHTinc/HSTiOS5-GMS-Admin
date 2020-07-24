//
//  ConstituentInteractionModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentInteractionModel: NSObject {
    
    var interaction_count: String?
    var question_id: String?
    var widgets_title : String?
    var tot_values : String?

    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["interaction_count"] as? String {
            self.interaction_count = data
        }
        if let data = dict["question_id"] as? String {
            self.question_id = data
        }
        if let data = dict["widgets_title"] as? String {
            self.widgets_title = data
        }
        if let data = dict["tot_values"] as? String {
            self.tot_values = data
        }

    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ConstituentInteractionModel {
        let constituentInteractionModel = ConstituentInteractionModel()
        constituentInteractionModel.loadFromDictionary(dict)
        return constituentInteractionModel
    }

}
