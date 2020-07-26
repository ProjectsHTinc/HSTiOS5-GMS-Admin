//
//  ProfileDetailPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ProfileDetailsData {
    let user_id: String?
    let user_role: String?
    let constituency_id : String?
    let pugathi_id : String?
    let full_name : String?
    let phone_number : String?
    let email_id : String?
    let gender : String?
    let address : String?
    let picture_url : String?
}

protocol ProfileDetailsView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setProfileDetails(user_id:String,user_role:String,constituency_id:String,pugathi_id:String,full_name:String,phone_number:String,email_id:String,gender:String,address:String,picture_url:String)
    func setEmpty(errorMessage:String)
}

class ProfileDetailPresenter: NSObject {
    
    private let profileDetailService: ProfileDetailService
    weak private var profileDetailsView : ProfileDetailsView?

    init(profileDetailService:ProfileDetailService) {
        self.profileDetailService = profileDetailService
    }
    
    func attachView(view:ProfileDetailsView) {
        profileDetailsView = view
    }
    
    func detachView() {
        profileDetailsView = nil
    }
    
    func getProfileDetails(user_id:String) {
          self.profileDetailsView?.startLoading()
          profileDetailService.callAPIUserProfileDetails(
            user_id: user_id, onSuccess: { (profiledetails) in
            self.profileDetailsView?.finishLoading()
                self.profileDetailsView?.setProfileDetails(user_id: profiledetails.user_id!, user_role: profiledetails.user_role!, constituency_id: profiledetails.constituency_id!, pugathi_id: profiledetails.pugathi_id!, full_name: profiledetails.full_name!, phone_number: profiledetails.phone_number!, email_id: profiledetails.email_id!, gender: profiledetails.gender!, address: profiledetails.address!, picture_url: profiledetails.picture_url!)
              },
              onFailure: { (errorMessage) in
                  self.profileDetailsView?.finishLoading()
                  self.profileDetailsView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
