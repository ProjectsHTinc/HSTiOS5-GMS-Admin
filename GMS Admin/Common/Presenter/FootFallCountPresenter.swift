//
//  FootFallCountPresenter.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit


struct FootFallData {
    
    var total_footfall_cnt : Int?
    var unique_footfall_cnt : Int?
    var repeated_footfall_cnt: Int?
    var unique_footfall_cnt_presntage: String?
    var repeated_footfall_cnt_presntage : String?
    var total_unique_footfall_cnt : Int?
    var other_unique_footfall_cnt: Int?
    var cons_unique_footfall_cnt: Int?
    var cons_unique_footfall_cnt_presntage: String?
    var other_unique_footfall_cnt_presntage: String?
    var constituency_cnt: Int?
    var cons_unique_cnt: Int?
    var cons_repeated_cnt: Int?
    var cons_unique_cnt_presntage: String?
    var cons_repeated_cnt_presntage: String?
    var other_cnt: Int?
    var other_unique_cnt: Int?
    var other_repeated_cnt: Int?
    var other_unique_cnt_presntage: String?
    var other_repeated_cnt_presntage: String?
    
}

protocol FootFallView : NSObjectProtocol {
    
    func startLoadingFF()
    func finishLoadingFF()
    func setFF(total_footfall_cnt: Int?, unique_footfall_cnt:Int?, repeated_footfall_cnt:Int?, repeated_footfall_cnt_presntage:String?,unique_footfall_cnt_presntage: String?,total_unique_footfall_cnt : Int?,other_unique_footfall_cnt: Int?,cons_unique_footfall_cnt: Int?,cons_unique_footfall_cnt_presntage: String?,other_unique_footfall_cnt_presntage: String?,constituency_cnt: Int?,cons_unique_cnt: Int?,cons_repeated_cnt: Int?,cons_unique_cnt_presntage: String?,cons_repeated_cnt_presntage: String?,other_cnt: Int?,other_unique_cnt: Int?,other_repeated_cnt: Int?,other_unique_cnt_presntage: String?,other_repeated_cnt_presntage: String?)
    
    
    func setEmptyFF(errorMessage:String)
}

class FootFallPresenter: NSObject {
    
    private let footFallService: FootFallService
    weak private var footFallView : FootFallView?
    
    init(footFallService:FootFallService) {
        self.footFallService = footFallService
    }
    
    func attachView(view:FootFallView) {
        footFallView = view
    }
    
    func detachView() {
        footFallView = nil
    }
    
    func getFootFall(paguthi:String,from_date:String,to_date:String) {
        self.footFallView?.startLoadingFF()
        footFallService.callAPIFootfall(
        paguthi: paguthi,from_date:from_date,to_date:to_date, onSuccess: { (tg) in
                self.footFallView?.finishLoadingFF()
            self.footFallView?.setFF(total_footfall_cnt: tg.total_footfall_cnt!, unique_footfall_cnt: tg.unique_footfall_cnt!, repeated_footfall_cnt: tg.repeated_footfall_cnt!, repeated_footfall_cnt_presntage: tg.repeated_footfall_cnt_presntage!,unique_footfall_cnt_presntage: tg.unique_footfall_cnt_presntage!, total_unique_footfall_cnt: tg.total_unique_footfall_cnt!, other_unique_footfall_cnt: tg.cons_unique_footfall_cnt!, cons_unique_footfall_cnt: tg.cons_unique_footfall_cnt!,cons_unique_footfall_cnt_presntage: tg.other_unique_footfall_cnt_presntage!,other_unique_footfall_cnt_presntage: tg.other_unique_footfall_cnt_presntage!, constituency_cnt: tg.constituency_cnt!, cons_unique_cnt: tg.cons_unique_cnt!,  cons_repeated_cnt: tg.cons_repeated_cnt!,cons_unique_cnt_presntage: tg.cons_unique_cnt_presntage!, cons_repeated_cnt_presntage: tg.cons_repeated_cnt_presntage!, other_cnt: tg.other_cnt!,  other_unique_cnt: tg.other_unique_cnt!, other_repeated_cnt: tg.other_repeated_cnt!, other_unique_cnt_presntage: tg.other_unique_cnt_presntage!,other_repeated_cnt_presntage: tg.unique_footfall_cnt_presntage!)
                
            },
            onFailure: { (errorMessage) in
                self.footFallView?.startLoadingFF()
                self.footFallView?.setEmptyFF(errorMessage: errorMessage)

            }
        )
    }

}
