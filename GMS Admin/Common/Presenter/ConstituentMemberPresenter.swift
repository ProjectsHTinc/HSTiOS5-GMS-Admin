//
//  ConstituentMemberPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//
//

import UIKit

struct ConstituentMemberData {
    
    var total: String?
    var malecount: String?
    var malepercenatge : String?
    var femalecount : String?
    var femalepercenatge: String?
    var others: String?
    var otherpercenatge : String?
    var malevoter_percentage : String?
    var femalevoter: String?
    var femalevoter_percentage: String?
    var maleaadhar : String?
    var maleaadhaar_percentage : String?
    var femaleaadhar: String?
    var femaleaadhaar_percentage: String?
    var having_mobilenumber : String?
    var mobile_percentage : String?
    var having_email: String?
    var email_percentage: String?
    var having_whatsapp : String?
    var whatsapp_percentage : String?
    var having_whatsapp_broadcast: String?
    var broadcast_percentage: String?
    var having_voter_percenatge : String?
    var having_vote_id : String?
    var having_dob_percentage: String?
    var having_dob: String?

}

protocol ConstituentMemberView : NSObjectProtocol {
    func startLoadingCi()
    func finishLoadingCI()
    func setCI(constituentMemberData:[ConstituentMemberData])
    func setEmptyCI(errorMessage:String)
}

class ConstituentMemberPresenter: NSObject {
    
    private let constituentMemberService:ConstituentMemberService
    weak private var constituentMemberView : ConstituentMemberView?
    
    init(constituentMemberService:ConstituentMemberService) {
        self.constituentMemberService = constituentMemberService
    }
    
    func attachView(view:ConstituentMemberView) {
        constituentMemberView = view
    }
    
    func detachView() {
        constituentMemberView = nil
    }
    
    func getTotalGreviances(paguthi:String,from_date:String,to_date:String,dynamic_db:String) {
        self.constituentMemberView?.startLoadingCi()
        constituentMemberService.callAPIConstituentMembers(paguthi: paguthi, from_date: from_date, to_date: to_date,dynamic_db:dynamic_db, onSuccess: { (ci) in
                self.constituentMemberView?.finishLoadingCI()
                if (ci.count == 0){
                } else {
                    let mappedUsers = ci.map {
                        return ConstituentMemberData(total: "\($0.total ?? "")", malecount: "\($0.malecount ?? "")", malepercenatge: "\($0.malepercenatge ?? "")",femalecount: "\($0.femalecount ?? "")", femalepercenatge: "\($0.femalepercenatge ?? "")", others: "\($0.others ?? "")",otherpercenatge: "\($0.otherpercenatge ?? "")", malevoter_percentage: "\($0.malevoter_percentage ?? "")", femalevoter: "\($0.femalevoter ?? "")",  femalevoter_percentage: "\($0.femalevoter_percentage ?? "")", maleaadhar: "\($0.maleaadhar ?? "")", maleaadhaar_percentage: "\($0.maleaadhaar_percentage ?? "")",femaleaadhar: "\($0.femaleaadhar ?? "")", femaleaadhaar_percentage: "\($0.femaleaadhaar_percentage ?? "")", having_mobilenumber: "\($0.having_mobilenumber ?? "")",mobile_percentage: "\($0.mobile_percentage ?? "")", having_email: "\($0.having_email ?? "")", email_percentage: "\($0.email_percentage ?? "")",having_whatsapp: "\($0.having_whatsapp ?? "")", whatsapp_percentage: "\($0.whatsapp_percentage ?? "")", having_whatsapp_broadcast: "\($0.having_whatsapp_broadcast ?? "")",broadcast_percentage: "\($0.broadcast_percentage ?? "")", having_voter_percenatge: "\($0.having_voter_percenatge ?? "")", having_vote_id: "\($0.having_vote_id ?? "")", having_dob_percentage: "\($0.having_dob_percentage ?? "")", having_dob: "\($0.having_dob ?? "")")
                                                     
                    }
                    self.constituentMemberView?.setCI(constituentMemberData: mappedUsers)

                }
            },
            onFailure: { (errorMessage) in
                self.constituentMemberView?.startLoadingCi()
                self.constituentMemberView?.setEmptyCI(errorMessage: errorMessage)

            }
        )
    }

}
