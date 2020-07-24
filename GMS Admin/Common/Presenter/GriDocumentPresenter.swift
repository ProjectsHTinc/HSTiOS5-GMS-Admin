//
//  GriDocumentPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct GriDocumentData {
    let doc_name : String
    let doc_file_name : String
    let created_at : String
}

protocol GriDocumentView: NSObjectProtocol {
    
    func startLoadingGri()
    func finishLoadingGri()
    func setGriDoc(GriDocument: [GriDocumentData])
    func setEmptyGri(errorMessage:String)
}

class GriDocumentPresenter: NSObject {
    
    private let griDocumentService: GriDocumentService
    weak private var griDocumentView : GriDocumentView?

    init(griDocumentService:GriDocumentService) {
        self.griDocumentService = griDocumentService
    }
    
    func attachView(view:GriDocumentView) {
        griDocumentView = view
    }
    
    func detachView() {
        griDocumentView = nil
    }
    
    func getGriDoc(constituent_id:String) {
          self.griDocumentView?.startLoadingGri()
          griDocumentService.callAPIGriDocument(
            constituent_id: constituent_id, onSuccess: { (plant) in
            self.griDocumentView?.finishLoadingGri()
                if (plant.count == 0){
                } else {
                  let mappedUsers = plant.map {
                    return GriDocumentData(doc_name: "\($0.doc_name ?? "")", doc_file_name: "\($0.doc_file_name ?? "")", created_at: "\($0.created_at ?? "")")
                     }
                    self.griDocumentView?.setGriDoc(GriDocument: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.griDocumentView?.finishLoadingGri()
                  self.griDocumentView?.setEmptyGri(errorMessage: errorMessage)

              }
          )
      }

}
