//
//  GlobalVariables.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 17/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class GlobalVariables: NSObject {
    
    static let shared: GlobalVariables = GlobalVariables()
    var selectedConstituencyName = String()
    var CLIENTURL = String()
    var Devicetoken = String()
    var userCount = Int()
    var user_id = String()
    var user_name = String()
    var user_location = String()
    var user_Image = String()
    var constituent_Id = String()
    var constituent_Count = Int()
    var interActionCount = Int()
    var selectedPaguthiId = String()
    var consGreivanceCount = Int()
    var sideMenuDropdown = String()
    var meetingAllCount = Int()
    var profGrivance = String()
    var staffCount = Int()
    var result_count = Int()
    var constituent_MemberCount = String()
    var totalMeetingsCount = String()
    var totalGrievancesCount = String()
    var constituentInteractionCount = String()
    var user_role = String()
    var widgetFromDate = String()
    var widgetToDate = String()
    var total_greetings = Int()
    var birthday_wish_count = String()
    var festival_wishes_count = String()
    var vedioCount = Int()
}
