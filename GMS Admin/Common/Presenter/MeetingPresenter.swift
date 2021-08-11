//
//  MeetingPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct MeetingData {
    let meeting_detail : String
    let meeting_date : String
    let meeting_status : String
    let meeting_title : String
}

protocol MeetingView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setMeeting(meeting: [MeetingData])
    func setEmpty(errorMessage:String)
}

class MeetingPresenter {
    
      private let meetingService: MeetingService
      weak private var meetingView : MeetingView?

      init(meetingService:MeetingService) {
          self.meetingService = meetingService
      }
      
      func attachView(view:MeetingView) {
          meetingView = view
      }
      
      func detachView() {
          meetingView = nil
      }
      
    func getMeeting(constituency_id:String,offset:String,rowcount:String,dynamic_db:String) {
          self.meetingView?.startLoading()
          meetingService.callAPIMeeting(
            constituency_id: constituency_id,dynamic_db:dynamic_db, offset: offset,rowcount: rowcount, onSuccess: { (meeting) in
                  self.meetingView?.finishLoading()
                  if (meeting.count == 0){
                  } else {
                    let mappedUsers = meeting.map {
                        return MeetingData(meeting_detail: "\($0.meeting_detail ?? "")", meeting_date: "\($0.meeting_date ?? "")", meeting_status: "\($0.meeting_status ?? "")", meeting_title: "\($0.meeting_title ?? "")")
                       }
                    self.meetingView?.setMeeting(meeting: mappedUsers)
                  }
              },
              onFailure: { (errorMessage) in
                  self.meetingView?.finishLoading()
                  self.meetingView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
