//
//  PlantDonationPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct PlantDonationData {
    let no_of_plant : String
    let name_of_plant : String
    let created_at : String
}

protocol PlantDonationView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setPlantDonation(plant: [PlantDonationData])
    func setEmpty(errorMessage:String)
}

class PlantDonationPresenter {
    
    private let plantDonationService: PlantDonationService
    weak private var plantDonationView : PlantDonationView?

    init(plantDonationService:PlantDonationService) {
        self.plantDonationService = plantDonationService
    }
    
    func attachView(view:PlantDonationView) {
        plantDonationView = view
    }
    
    func detachView() {
        plantDonationView = nil
    }
    
    func getPlantDonation(constituent_id:String) {
          self.plantDonationView?.startLoading()
          plantDonationService.callAPIPlant(
            constituent_id: constituent_id, onSuccess: { (plant) in
            self.plantDonationView?.finishLoading()
                if (plant.count == 0){
                } else {
                  let mappedUsers = plant.map {
                    return PlantDonationData(no_of_plant: "\($0.no_of_plant ?? "")", name_of_plant: "\($0.name_of_plant ?? "")", created_at: "\($0.created_at ?? "")")
                     }
                  self.plantDonationView?.setPlantDonation(plant: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.plantDonationView?.finishLoading()
                  self.plantDonationView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
