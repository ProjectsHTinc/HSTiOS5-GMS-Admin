//
//  DashBoardModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 15/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SwiftyJSON

class DashBoardData: Codable {
    
    var disp_month, total : String?
     
    var new_grev, repeated_grev : Double?
    
    init(json:JSON) {
        
        self.disp_month = json["disp_month"].stringValue
        self.total = json["total"].stringValue
        self.new_grev = json["new_grev"].double
        self.repeated_grev = json["repeated_grev"].double

    }
}
