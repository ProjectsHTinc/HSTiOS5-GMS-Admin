//
//  GreivancesAllPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct GreivancesAllData:Codable {
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
    let constituent_id: String
    let full_name: String

}

protocol GreivancesAllView: NSObjectProtocol {
    func startLoadingGriAll()
    func finishLoadingGriAll()
    func setGrieAll(GriAll: [GreivancesAllData])
    func setEmpty(errorMessage:String)
}

class GreivancesAllPresenter: NSObject {
    
    private let greivancesAllService: GreivancesAllService
    weak private var greivancesAllView : GreivancesAllView?

    init(greivancesAllService:GreivancesAllService) {
        self.greivancesAllService = greivancesAllService
    }
    
    func attachView(view:GreivancesAllView) {
        greivancesAllView = view
    }
    
    func detachView() {
        greivancesAllView = nil
    }
    
    func getGrieAll(url : String, keyword: String, paguthi:String, offset:String, rowcount:String, grievance_type: String,dynamic_db:String) {
          self.greivancesAllView?.startLoadingGriAll()
          greivancesAllService.callAPIGreivancesAll(
            url: url, keyword: keyword,dynamic_db:dynamic_db, paguthi: paguthi, offset: offset, rowcount: rowcount, grievance_type: grievance_type, onSuccess: { (grieAll) in
            self.greivancesAllView?.finishLoadingGriAll()
                if (grieAll.count == 0){
                } else {
                  let mappedUsers = grieAll.map {
                    return GreivancesAllData(paguthi_name: "\($0.paguthi_name ?? "")", seeker_info: "\($0.seeker_info ?? "")", grievance_name: "\($0.grievance_name ?? "")", sub_category_name: "\($0.sub_category_name ?? "")", grievance_type: "\($0.grievance_type ?? "")", petition_enquiry_no: "\($0.petition_enquiry_no ?? "")", status: "\($0.status ?? "")", created_at: "\($0.created_at ?? "")", grievance_date: "\($0.grievance_date ?? "")", description: "\($0.description ?? "")", updated_by: "\($0.updated_by ?? "")", id: "\($0.id ?? "")", reference_note: "\($0.reference_note ?? "")", updated_at: "\($0.updated_at ?? "")", constituent_id: "\($0.constituent_id ?? "")", full_name: "\($0.full_name ?? "")")
                     }
                    self.greivancesAllView?.setGrieAll(GriAll: mappedUsers)
                    UserDefaults.standard.setConsProfileInfo(mappedUsers, forKey: UserDefaultsKey.ConsProfilekey.rawValue)

                }

              },
              onFailure: { (errorMessage) in
                  self.greivancesAllView?.finishLoadingGriAll()
                  self.greivancesAllView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
