//
//  MeetingAllDetailUpdatePresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct MeetingAllDetailUpdateData {
    
    let msg : String
    let status : String

}

protocol MeetingAllDetailUpdateView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setMeetingUpdate(msg:String, status: String)
    func setEmpty(errorMessage:String)
}


class MeetingAllDetailUpdatePresenter: NSObject {
    
    private let meetingAllDetailUpdateService: MeetingAllDetailUpdateService
    weak private var meetingAllDetailUpdateView : MeetingAllDetailUpdateView?

    init(meetingAllDetailUpdateService:MeetingAllDetailUpdateService) {
        self.meetingAllDetailUpdateService = meetingAllDetailUpdateService
    }
    
    func attachView(view:MeetingAllDetailUpdateView) {
        meetingAllDetailUpdateView = view
    }
    
    func detachView() {
        meetingAllDetailUpdateView = nil
    }
    
    func getMeetingAllDetail(meeting_id : String, user_id : String, status : String,dynamic_db:String) {
          self.meetingAllDetailUpdateView?.startLoading()
          meetingAllDetailUpdateService.callAPIMeetingAllDetailUpdate(
            meeting_id: meeting_id, dynamic_db:dynamic_db,user_id: user_id, status: status, onSuccess: { (meettingUpdate) in
            self.meetingAllDetailUpdateView?.finishLoading()
                self.meetingAllDetailUpdateView?.setMeetingUpdate(msg: meettingUpdate.msg!, status: meettingUpdate.status!)
              },
              onFailure: { (errorMessage) in
                  self.meetingAllDetailUpdateView?.finishLoading()
                  self.meetingAllDetailUpdateView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
