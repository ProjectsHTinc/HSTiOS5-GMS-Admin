//
//  ClientUrlModel.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ClientUrlModel {
    
    var id: Int?
    var constituency_id: Int?
    var constituency_name : String?
    var client_api_url : String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["id"] as? Int {
            self.id = data
        }
        if let data = dict["constituency_id"] as? Int {
            self.constituency_id = data
        }
        if let data = dict["constituency_name"] as? String {
            self.constituency_name = data
        }
        if let data = dict["client_api_url"] as? String {
            self.client_api_url = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ClientUrlModel {
        let clientUrl = ClientUrlModel()
        clientUrl.loadFromDictionary(dict)
        return clientUrl
    }

}
