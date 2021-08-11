//
//  MeetingAllPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct MeetingAllData {
    let id : String
    let full_name : String
    let paguthi_name : String
    let meeting_title : String
    let meeting_date : String
    let meeting_status : String
    let created_by : String
}

protocol MeetingAllDataView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setMeetingAll(meetingAll: [MeetingAllData])
    func setEmpty(errorMessage:String)
}

class MeetingAllPresenter: NSObject {
    
    private let meetingAllService: MeetingAllService
    weak private var meetingAllDataView : MeetingAllDataView?

    init(meetingAllService:MeetingAllService) {
        self.meetingAllService = meetingAllService
    }
    
    func attachView(view:MeetingAllDataView) {
        meetingAllDataView = view
    }
    
    func detachView() {
        meetingAllDataView = nil
    }
    
    func getMeetingAll(url: String, keyword: String, constituency_id:String, offset:String, rowcount:String,dynamic_db:String) {
          self.meetingAllDataView?.startLoading()
          meetingAllService.callAPIMeetingAll(
            url: url, keyword: keyword, dynamic_db:dynamic_db, constituency_id: constituency_id, offset: offset, rowcount: rowcount, onSuccess: { (meettingAll) in
            self.meetingAllDataView?.finishLoading()
                if (meettingAll.count == 0){
                } else {
                  let mappedUsers = meettingAll.map {
                    return MeetingAllData(id: "\($0.id ?? "")", full_name: "\($0.full_name ?? "")", paguthi_name: "\($0.paguthi_name ?? "")", meeting_title: "\($0.meeting_title ?? "")", meeting_date: "\($0.meeting_date ?? "")", meeting_status: "\($0.meeting_status ?? "")", created_by: "\($0.created_by ?? "")")
                     }
                    self.meetingAllDataView?.setMeetingAll(meetingAll: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.meetingAllDataView?.finishLoading()
                  self.meetingAllDataView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
