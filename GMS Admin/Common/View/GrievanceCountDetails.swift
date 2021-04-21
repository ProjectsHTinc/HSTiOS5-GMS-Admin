//
//  GreetingCountDetails.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/01/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class GreetingCountDetails: UIViewController,TotalGrevianceView {

    @IBOutlet weak var grievanceCount: UILabel!
    @IBOutlet weak var enquiryCount: UILabel!
    @IBOutlet weak var petionCount: UILabel!
    @IBOutlet weak var petionCompletedCount: UILabel!
    @IBOutlet weak var petionPendingCount: UILabel!
    @IBOutlet weak var petionRejectedCount: UILabel!
    @IBOutlet weak var petionCompletedPercentage: UILabel!
    @IBOutlet weak var petionPendingPercentage: UILabel!
    @IBOutlet weak var petionRejectedPercentage: UILabel!
    @IBOutlet weak var petionCount1: UILabel!
    @IBOutlet weak var onlinepetionPercentage: UILabel!
    @IBOutlet weak var civicPetionPercentage: UILabel!
    @IBOutlet weak var onlinePetionCount: UILabel!
    @IBOutlet weak var civicPetionCount: UILabel!
    @IBOutlet weak var onlinePetion: UILabel!
    @IBOutlet weak var onlinepetionCompletedCount: UILabel!
    @IBOutlet weak var onlinepetionPendingCount: UILabel!
    @IBOutlet weak var onlinepetionRejectedCount: UILabel!
    @IBOutlet weak var onlinepetionCompletedPercentage: UILabel!
    @IBOutlet weak var onlinepetionPendingPercentage: UILabel!
    @IBOutlet weak var onlinepetionRejectedPercentage: UILabel!
    @IBOutlet weak var civicPetion: UILabel!
    @IBOutlet weak var civicPetionCompletedCount: UILabel!
    @IBOutlet weak var civicPetionPendingCount: UILabel!
    @IBOutlet weak var civicPetionRejectedCount: UILabel!
    @IBOutlet weak var civicPetionCompletedPercentage: UILabel!
    @IBOutlet weak var civicPetionPendingPercentage: UILabel!
    @IBOutlet weak var civicPetionRejectedPercentage: UILabel!
    @IBOutlet weak var enquiryCount1: UILabel!
    @IBOutlet weak var onlineEnquiryCount: UILabel!
    @IBOutlet weak var civicEnqiryPercentage: UILabel!
    @IBOutlet weak var onlineEnquiryPercentage: UILabel!
    @IBOutlet weak var civicEnquiryPercentage: UILabel!
    
    var paguthi_Id = String()
    let presenterTG = TotalGreviancesPresenter(totalGreviancesSerVice: TotalGreviancesSerVice())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.enquiryCount.text = enquiry_count
        self.petionCount.text = petition_count
        self.petionCompletedCount.text = petition_completed
        self.petionPendingCount.text = petition_pending
        self.petionRejectedCount.text = petition_rejected
        self.petionCompletedPercentage.text = petition_completed_percentage
        self.petionPendingPercentage.text = petition_pending_percentage
        self.petionRejectedPercentage.text = petition_rejected_percentage
        self.petionCount1.text = petition_count
        self.onlinepetionPercentage.text = no_of_online_percentage
        self.civicPetionPercentage.text = no_of_civic_percentage
        self.onlinePetionCount.text = no_of_online
        self.civicPetionCount.text = no_of_civic
        self.onlinePetion.text = no_of_online
        self.onlinepetionCompletedCount.text = petition_completedOnline
        self.onlinepetionPendingCount.text = petition_pendingOnline
        self.onlinepetionRejectedCount.text = petition_rejectedOnline
        self.onlinepetionCompletedPercentage.text = petition_completed_percentage
        self.onlinepetionPendingPercentage.text = petition_pending_percentageOnline
        self.onlinepetionRejectedPercentage.text = petition_rejected_percentageOnline
        self.civicPetion.text = no_of_civic
        self.civicPetionCompletedCount.text = petition_completedCivic
        self.civicPetionPendingCount.text = petition_pendingCivic
        self.civicPetionRejectedCount.text = petition_rejectedCivic
        self.civicPetionCompletedPercentage.text = petition_completed_percentageCivic
        self.civicPetionPendingPercentage.text = petition_pending_percentage
        self.civicPetionRejectedPercentage.text = petition_rejected_percentageCivic
        self.enquiryCount1.text = enquiry_count
        self.onlineEnquiryCount.text = no_of_onlineEQ
        self.civicEnqiryPercentage.text = no_of_civic_percentageEQ
        self.onlineEnquiryPercentage.text = no_of_online_percentageEQ
        self.civicEnquiryPercentage.text = no_of_civic_percentageEQ
        
    }

    @IBAction func dissmissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
