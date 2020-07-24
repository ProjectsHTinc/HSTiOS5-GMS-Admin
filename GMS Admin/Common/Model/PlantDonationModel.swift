//
//  PlantDonationModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class PlantDonationModel {
    
     var id: String?
     var constituent_id: String?
     var no_of_plant : String?
     var name_of_plant : String?
     var created_at : String?


     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
          if let data = dict["id"] as? String {
             self.id = data
          }
        
          if let data = dict["constituent_id"] as? String {
             self.constituent_id = data
          }
        
          if let data = dict["no_of_plant"] as? String {
             self.no_of_plant = data
          }
        
          if let data = dict["name_of_plant"] as? String {
             self.name_of_plant = data
          }
        
         if let data = dict["created_at"] as? String {
            self.created_at = data
         }
      
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> PlantDonationModel {
        let plantDonationModel = PlantDonationModel()
        plantDonationModel.loadFromDictionary(dict)
        return plantDonationModel
    }

}
