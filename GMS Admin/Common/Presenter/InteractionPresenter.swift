//
//  InteractionPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct InteractionData {
    let interaction_question : String
    let interaction_text : String
    let status : String
}

protocol InteractionView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setInteraction(interaction: [InteractionData])
    func setEmpty(errorMessage:String)
}

class InteractionPresenter: NSObject {
    
    private let interactionService: InteractionService
    weak private var interactionView : InteractionView?

    init(interactionService:InteractionService) {
        self.interactionService = interactionService
    }
    
    func attachView(view:InteractionView) {
        interactionView = view
    }
    
    func detachView() {
        interactionView = nil
    }
    
    func getInteraction(constituent_id:String) {
          self.interactionView?.startLoading()
          interactionService.callAPIInteraction(
            constituent_id: constituent_id, onSuccess: { (plant) in
            self.interactionView?.finishLoading()
                if (plant.count == 0){
                } else {
                  let mappedUsers = plant.map {
                    return InteractionData(interaction_question: "\($0.interaction_question ?? "")", interaction_text: "\($0.interaction_text ?? "")", status: "\($0.status ?? "")")
                     }
                  self.interactionView?.setInteraction(interaction: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.interactionView?.finishLoading()
                  self.interactionView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
