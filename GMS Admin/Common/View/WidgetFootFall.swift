//
//  WidgetFootFall.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class WidgetFootFall: UIViewController,FootFallView {
 
    @IBOutlet weak var footfallCount: UILabel!
    @IBOutlet weak var uniqueFootfall: UILabel!
    @IBOutlet weak var totalFootfall: UILabel!
    @IBOutlet weak var constituentFootfall: UILabel!
    @IBOutlet weak var otherFootfall: UILabel!
    
    var paguthi_Id = String()
    let presenterTG = FootFallPresenter(footFallService: FootFallService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CallAPIFF()
        // Do any additional setup after loading the view.
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
    
    func setFF(total_footfall_cnt: Int?, unique_footfall_cnt:Int?, repeated_footfall_cnt:Int?, repeated_footfall_cnt_presntage:String?,unique_footfall_cnt_presntage: String?,total_unique_footfall_cnt : Int?,other_unique_footfall_cnt: Int?,cons_unique_footfall_cnt: Int?,cons_unique_footfall_cnt_presntage: String?,other_unique_footfall_cnt_presntage: String?,constituency_cnt: Int?,cons_unique_cnt: Int?,cons_repeated_cnt: Int?,cons_unique_cnt_presntage: String?,cons_repeated_cnt_presntage: String?,other_cnt: Int?,other_unique_cnt: Int?,other_repeated_cnt: Int?,other_unique_cnt_presntage: String?,other_repeated_cnt_presntage: String?) {
        
        footfallCount.text  = "FootFall Count - \(String(total_footfall_cnt!))"
        uniqueFootfall.text = String(unique_footfall_cnt!)
        totalFootfall.text  = String(total_footfall_cnt!)
        otherFootfall.text = String(other_unique_footfall_cnt!)
        constituentFootfall.text = String(constituency_cnt!)
    }
    
    func setEmptyFF(errorMessage: String) {
        
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    

    @IBAction func dissmissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func knowMoreAction(_ sender: Any) {
        self.performSegue(withIdentifier: "knowMore", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "knowMore")
        {
            let vc = segue.destination as! FootFallDetails
            vc.paguthi_Id = GlobalVariables.shared.selectedPaguthiId
        }
    }
}
