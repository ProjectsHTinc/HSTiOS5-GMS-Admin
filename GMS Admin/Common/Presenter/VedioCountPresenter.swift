//
//  VedioCountPresenter.swift
//  
//
//  Created by HappysanziMac on 21/04/21.
//

import Foundation

struct VedioCountData {
    
    var office_name: String?
    var video_cnt: String?
    var video_percentage : String?
    
  
}

protocol VedioCountView : NSObjectProtocol {
    func startLoadingCi()
    func finishLoadingCI()
    func setCI(vedioCountData:[VedioCountData])
    func setEmptyCI(errorMessage:String)
}

class VedioCountPresenter: NSObject {
    
    private let vedioCountService:VedioCountService
    weak private var vedioCountView : VedioCountView?
    
    init(vedioCountService:VedioCountService) {
        self.vedioCountService = vedioCountService
    }
    
    func attachView(view:VedioCountView) {
        vedioCountView = view
    }
    
    func detachView() {
        vedioCountView = nil
    }
    
    func getvedioCount(paguthi:String,from_date:String,to_date:String) {
        self.vedioCountView?.startLoadingCi()
        vedioCountService.callAPIVedioCount(paguthi: paguthi, from_date: from_date, to_date: to_date, onSuccess: { (ci) in
                self.vedioCountView?.finishLoadingCI()
                if (ci.count == 0){
                } else {
                    let mappedUsers = ci.map {
                        return VedioCountData(office_name: "\($0.office_name ?? "")", video_cnt: "\($0.video_cnt ?? "")", video_percentage: "\($0.video_percentage ?? "")")
                                                     
                    }
                    self.vedioCountView?.setCI(vedioCountData: mappedUsers)

                }
            },
            onFailure: { (errorMessage) in
                self.vedioCountView?.startLoadingCi()
                self.vedioCountView?.setEmptyCI(errorMessage: errorMessage)

            }
        )
    }

}
