//
//  FootFallDetails.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class FootFallDetails: UIViewController,FootFallView {
    
    @IBOutlet weak var uniqueFootfallCount: UILabel!
    @IBOutlet weak var totalFootfallCount: UILabel!
    @IBOutlet weak var ConstFootfallCount: UILabel!
    @IBOutlet weak var otherFootfallCount: UILabel!
    @IBOutlet weak var uniqueFFpercentage: UILabel!
    @IBOutlet weak var uniqueOtherFFPercentage: UILabel!
    @IBOutlet weak var totalUniqueFFpercentage: UILabel!
    @IBOutlet weak var totalFFothersPercentage: UILabel!
    @IBOutlet weak var constUniquePercentage: UILabel!
    @IBOutlet weak var constRepeatedPercentage: UILabel!
    @IBOutlet weak var otherUniquePercentage: UILabel!
    @IBOutlet weak var otherRepeatedPercentage: UILabel!
    @IBOutlet weak var uniqueConstCount: UILabel!
    @IBOutlet weak var uniquerOthersCount: UILabel!
    @IBOutlet weak var totalUniqueCount: UILabel!
    @IBOutlet weak var totalRepeatedCount: UILabel!
    @IBOutlet weak var constUniqueCount: UILabel!
    @IBOutlet weak var constRepeatedCount: UILabel!
    @IBOutlet weak var otherUniqueCount: UILabel!
    @IBOutlet weak var otherRepeatedCount: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var navView: UIView!
    
    let presenterTG = FootFallPresenter(footFallService: FootFallService())
    var paguthi_Id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.CallAPIFF()
        view1.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        view2.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        view3.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        view4.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        navView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 2.0, opacity: 0.35)
    }
    
    func CallAPIFF ()
    {
        presenterTG.attachView(view: self)
        presenterTG.getFootFall(paguthi: paguthi_Id, from_date: GlobalVariables.shared.widgetFromDate, to_date: GlobalVariables.shared.widgetToDate,dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    func startLoadingFF() {
//
    }
    
    func finishLoadingFF() {
//
    }
    
    func setFF(total_footfall_cnt: Int?, unique_footfall_cnt: Int?, repeated_footfall_cnt: Int?, repeated_footfall_cnt_presntage: String?, unique_footfall_cnt_presntage: String?, total_unique_footfall_cnt: Int?, other_unique_footfall_cnt: Int?, cons_unique_footfall_cnt: Int?, cons_unique_footfall_cnt_presntage: String?, other_unique_footfall_cnt_presntage: String?, constituency_cnt: Int?, cons_unique_cnt: Int?, cons_repeated_cnt: Int?, cons_unique_cnt_presntage: String?, cons_repeated_cnt_presntage: String?, other_cnt: Int?, other_unique_cnt: Int?, other_repeated_cnt: Int?, other_unique_cnt_presntage: String?, other_repeated_cnt_presntage: String?) {
        
        
        uniqueFootfallCount.text = String(unique_footfall_cnt!)
        totalFootfallCount.text = String(total_footfall_cnt!)
        ConstFootfallCount.text = String(constituency_cnt!)
        otherFootfallCount.text = String(other_cnt!)
        uniqueFFpercentage.text = String("Singanallur (\(unique_footfall_cnt_presntage!)%)")
        uniqueOtherFFPercentage.text = String("Others (\(other_unique_footfall_cnt_presntage!)%)")
        totalUniqueFFpercentage.text = String("Unique (\(unique_footfall_cnt_presntage!)%)")
        totalFFothersPercentage.text = String("Repeat (\(repeated_footfall_cnt_presntage!)%)")
        constUniquePercentage.text = String("Unique (\(cons_unique_cnt_presntage!)%)")
        constRepeatedPercentage.text = String("Repeat (\(cons_repeated_cnt_presntage!)%)")
        otherUniquePercentage.text = String("Unique (\(other_unique_cnt_presntage!)%)")
        otherRepeatedPercentage.text = String("Repeat (\(other_repeated_cnt_presntage!)%)")
        uniqueConstCount.text = String(cons_unique_cnt!)
        uniquerOthersCount.text = String(other_unique_cnt!)
        totalUniqueCount.text = String(cons_unique_cnt!)
        totalRepeatedCount.text = String(cons_repeated_cnt!)
        constUniqueCount.text = String(cons_unique_cnt!)
        constRepeatedCount.text = String(cons_repeated_cnt!)
        otherUniqueCount.text = String(other_unique_cnt!)
        otherRepeatedCount.text = String(other_repeated_cnt!)
    }
    
    func setEmptyFF(errorMessage: String) {
        
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

