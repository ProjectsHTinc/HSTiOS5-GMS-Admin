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
}
