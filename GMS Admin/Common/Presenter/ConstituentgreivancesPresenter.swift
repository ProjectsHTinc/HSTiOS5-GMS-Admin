//
//  ConstituentgreivancesPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 20/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ConstituentGreivancesData {
    let paguthi_name : String
    let seeker_info : String
    let grievance_name : String
    let sub_category_name : String
    let grievance_type : String
    let petition_enquiry_no : String
    let status : String
    let created_at : String
    let grievance_date : String
    let description : String
    let updated_by : String
    let id : String
    let reference_note : String
    let updated_at: String

}

protocol ConstituentGreivancesView: NSObjectProtocol {
    func startLoadingGri()
    func finishLoadingGri()
    func setConsGrie(ConsGri: [ConstituentGreivancesData])
    func setEmpty(errorMessage:String)
}

class ConstituentgreivancesPresenter: NSObject {
    
    private let constituentGreivancesService: ConstituentGreivancesService
    weak private var constituentGreivancesView : ConstituentGreivancesView?

    init(constituentGreivancesService:ConstituentGreivancesService) {
        self.constituentGreivancesService = constituentGreivancesService
    }
    
    func attachView(view:ConstituentGreivancesView) {
        constituentGreivancesView = view
    }
    
    func detachView() {
        constituentGreivancesView = nil
    }
    
    func getConsGrie(constituent_id:String,dynamic_db:String) {
          self.constituentGreivancesView?.startLoadingGri()
          constituentGreivancesService.callAPIConstituentGrievances(
            constituent_id: constituent_id, dynamic_db:dynamic_db,onSuccess: { (plant) in
            self.constituentGreivancesView?.finishLoadingGri()
                if (plant.count == 0){
                } else {
                  let mappedUsers = plant.map {
                    return ConstituentGreivancesData(paguthi_name: "\($0.paguthi_name ?? "")", seeker_info: "\($0.seeker_info ?? "")", grievance_name: "\($0.grievance_name ?? "")", sub_category_name: "\($0.sub_category_name ?? "")", grievance_type: "\($0.grievance_type ?? "")", petition_enquiry_no: "\($0.petition_enquiry_no ?? "")", status: "\($0.status ?? "")", created_at: "\($0.created_at ?? "")", grievance_date: "\($0.grievance_date ?? "")", description: "\($0.description ?? "")", updated_by: "\($0.updated_by ?? "")", id: "\($0.id ?? "")", reference_note: "\($0.reference_note ?? "")", updated_at: "\($0.updated_at ?? "")")
                     }
                    self.constituentGreivancesView?.setConsGrie(ConsGri: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.constituentGreivancesView?.finishLoadingGri()
                  self.constituentGreivancesView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
