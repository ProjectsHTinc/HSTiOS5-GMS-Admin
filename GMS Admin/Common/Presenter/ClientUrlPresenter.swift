//
//  ClientUrlPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct clientUrlData {
    let client_api_url: String
}

protocol ClientUrlView : NSObjectProtocol {

    func setclientUrl(clientUrl:[clientUrlData])
    func setEmpty(errorMessage:String)
}

class ClientUrlPresenter {
    
    private let clientUrlService:ClientUrlService
    weak private var clientUrlView : ClientUrlView?

    init(clientUrlService:ClientUrlService) {
        self.clientUrlService = clientUrlService
    }

    func attachViewClientUrl(view:ClientUrlView) {
        clientUrlView = view
    }

    func detachViewClientUrl() {
        clientUrlView = nil
    }

    func getclientUrl(select_ID:String) {

        clientUrlService.callAPIGetClientUrl(
            select_ID: select_ID, onSuccess: { (client_url) in
                if (client_url.count == 0){
                }
                else {
                    let mappedUsers = client_url.map {
                        return clientUrlData(client_api_url: "\($0.client_api_url ?? "")")
                    }
                    self.clientUrlView?.setclientUrl(clientUrl: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.clientUrlView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }

}
