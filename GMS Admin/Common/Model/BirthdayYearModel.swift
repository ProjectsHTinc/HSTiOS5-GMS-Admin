//
//  BirthdayYearModel.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//
import Foundation

class BirthdayYearModel: NSObject {

        var year_name: String?
        
    
        // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
            if let data = dict["year_name"] as? String {
                self.year_name = data
            }

    }
        
        // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> BirthdayYearModel {
        let caategoeryModel = BirthdayYearModel()
        caategoeryModel.loadFromDictionary(dict)
        return caategoeryModel
    }
}
