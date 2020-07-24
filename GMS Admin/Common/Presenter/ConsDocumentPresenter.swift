//
//  ConsDocumentPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ConsDocumentData {
    let doc_name : String
    let doc_file_name : String
    let created_at : String
}

protocol ConsDocumentView: NSObjectProtocol {
    
    func startLoadingCons()
    func finishLoadingCons()
    func setConsDoc(consDocument: [ConsDocumentData])
    func setEmptyCons(errorMessage:String)
}

class ConsDocumentPresenter: NSObject {
    
    private let consDocumentService: ConsDocumentService
    weak private var consDocumentView : ConsDocumentView?

    init(consDocumentService:ConsDocumentService) {
        self.consDocumentService = consDocumentService
    }
    
    func attachView(view:ConsDocumentView) {
        consDocumentView = view
    }
    
    func detachView() {
        consDocumentView = nil
    }
    
    func getConsDoc(constituent_id:String) {
          self.consDocumentView?.startLoadingCons()
          consDocumentService.callAPIConsDocument(
            constituent_id: constituent_id, onSuccess: { (plant) in
            self.consDocumentView?.finishLoadingCons()
                if (plant.count == 0){
                } else {
                  let mappedUsers = plant.map {
                    return ConsDocumentData(doc_name: "\($0.doc_name ?? "")", doc_file_name: "\($0.doc_file_name ?? "")", created_at: "\($0.created_at ?? "")")
                     }
                    self.consDocumentView?.setConsDoc(consDocument: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.consDocumentView?.finishLoadingCons()
                  self.consDocumentView?.setEmptyCons(errorMessage: errorMessage)

              }
          )
      }

}
