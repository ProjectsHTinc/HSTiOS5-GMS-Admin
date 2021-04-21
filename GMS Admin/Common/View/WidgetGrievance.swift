//
//  WidgetGrievance.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class WidgetGrievance: UIViewController,TotalGrevianceView{
    

    @IBOutlet weak var grievanceCount: UILabel!
    @IBOutlet weak var overallGrievanceCount: UILabel!
    @IBOutlet weak var petion: UILabel!
    @IBOutlet weak var onlinePetion: UILabel!
    @IBOutlet weak var civicPetion: UILabel!
    @IBOutlet weak var enquiry: UILabel!
    @IBOutlet weak var enquiryonlinePetion: UILabel!
    @IBOutlet weak var enquiryCivicPetion: UILabel!
    
    var paguthi_Id = String()
    
  let presenterTG = TotalGreviancesPresenter(totalGreviancesSerVice: TotalGreviancesSerVice())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
     self.CallAPITG()
        
    }
        
   func CallAPITG ()
    {
        presenterTG.attachView(view: self)
    presenterTG.getTotalGreviances(paguthi: paguthi_Id,from_date:GlobalVariables.shared.widgetFromDate,to_date: GlobalVariables.shared.widgetFromDate)
    }
    
    func startLoadingTg() {
//
    }
    
    func finishLoadingTg() {
//
    }
    
    func setEmptyTg(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    
    func setTg(tot_grive_count: Int?, enquiry_count: String?, petition_count: String?,  petition_rejected_percentageOnline: String?, no_of_civicOnline: String?, no_of_online_percentageOnline: String?, petition_completedOnline: String?, petition_pendingOnline: String?, petition_pending_percentageOnline: String?, petition_rejectedOnline: String?, petition_rejected_percentageCivic: String?, petition_rejectedCivic: String?, petition_completed_percentageCivic: String?, petition_completedCivic: String?, petition_pendingCivic: String?, no_of_civic_percentageEQ: String?, no_of_civicEQ: String?, no_of_online_percentageEQ: String?, no_of_onlineEQ: String?, no_of_online: String?, no_of_online_percentage: String?, no_of_civic: String?, no_of_civic_percentage: String?, petition_pending_percentage: String?, petition_pending: String?, petition_rejected_percentage: String?, petition_rejected: String?, petition_completed: String?, petition_completed_percentage: String?) {
        
        self.grievanceCount.text = String(tot_grive_count!)
        self.overallGrievanceCount.text = String(tot_grive_count!)
        self.petion.text = petition_count
        self.onlinePetion.text = no_of_online
        self.civicPetion.text = no_of_civic
        self.enquiry.text = enquiry_count
        self.enquiryonlinePetion.text = no_of_onlineEQ
        self.enquiryCivicPetion.text = no_of_civicEQ
    }
   
    @IBAction func knowMoreAction(_ sender: Any) {
        
    }
    
    @IBAction func dissmissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
