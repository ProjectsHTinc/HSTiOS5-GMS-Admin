//
//  ConstituentMemberPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ConstituentMemberData {
    let member_count : Int?
    let male_count: Int?
    let female_count: Int?
    let voterid_count: Int?
    let aadhaar_count: Int?
}

protocol ConstituentMemberView : NSObjectProtocol {
    func startLoadingCm()
    func finishLoadingCm()
    func setCm(member_count: Int?, male_count:Int?, female_count:Int?, voterid_count:Int?, aadhaar_count:Int?)
    func setEmptyCm(errorMessage:String)
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
    
    func getConstituentMember(paguthi:String) {
        self.constituentMemberView?.startLoadingCm()
        constituentMemberService.callAPIConstituentMembers(
            paguthi: paguthi, onSuccess: { (cm) in
                self.constituentMemberView?.finishLoadingCm()
                self.constituentMemberView?.setCm(member_count: cm.member_count!, male_count: cm.male_count!, female_count: cm.female_count!, voterid_count: cm.voterid_count!, aadhaar_count: cm.aadhaar_count!)
            },
            onFailure: { (errorMessage) in
                self.constituentMemberView?.finishLoadingCm()
                self.constituentMemberView?.setEmptyCm(errorMessage: errorMessage)

            }
        )
    }

}
