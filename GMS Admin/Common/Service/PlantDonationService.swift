//
//  PlantDonationService.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class PlantDonationService {
    
    public func callAPIPlant(constituent_id:String, onSuccess successCallback: ((_ plant: [PlantDonationModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIPlant(
          constituent_id: constituent_id, onSuccess: { (plant) in
                successCallback?(plant)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
