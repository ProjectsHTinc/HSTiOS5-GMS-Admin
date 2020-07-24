//
//  MeetingAllDetailPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct MeetingAllDetailData {
    
    let id : String
    let full_name : String
    let paguthi_name : String
    let meeting_title : String
    let meeting_date : String
    let meeting_status : String
    let created_by : String
    let meeting_detail : String
}

protocol MeetingAllDetailView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setMeetingDetail(meetingdetail: [MeetingAllDetailData])
    func setEmpty(errorMessage:String)
}


class MeetingAllDetailPresenter: NSObject {
    
    
    private let meetingAllDetailService: MeetingAllDetailService
    weak private var meetingAllDetailView : MeetingAllDetailView?

    init(meetingAllDetailService:MeetingAllDetailService) {
        self.meetingAllDetailService = meetingAllDetailService
    }
    
    func attachView(view:MeetingAllDetailView) {
        meetingAllDetailView = view
    }
    
    func detachView() {
        meetingAllDetailView = nil
    }
    
    func getMeetingAllDetail(meeting_id : String) {
          self.meetingAllDetailView?.startLoading()
          meetingAllDetailService.callAPIMeetingAllDetail(
            meeting_id: meeting_id,  onSuccess: { (meettingAll) in
            self.meetingAllDetailView?.finishLoading()
                if (meettingAll.count == 0){
                } else {
                  let mappedUsers = meettingAll.map {
                    return MeetingAllDetailData(id: "\($0.id ?? "")", full_name: "\($0.full_name ?? "")", paguthi_name: "\($0.paguthi_name ?? "")", meeting_title: "\($0.meeting_title ?? "")", meeting_date: "\($0.meeting_date ?? "")", meeting_status: "\($0.meeting_status ?? "")", created_by: "\($0.created_by ?? "")", meeting_detail: "\($0.meeting_detail ?? "")")
                     }
                    self.meetingAllDetailView?.setMeetingDetail(meetingdetail: mappedUsers)
                }

              },
              onFailure: { (errorMessage) in
                  self.meetingAllDetailView?.finishLoading()
                  self.meetingAllDetailView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
