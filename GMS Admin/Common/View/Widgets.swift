//
//  Widgets.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Widgets: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var label1: UILabel!
    @IBOutlet var valueLabel1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var valueLabel2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var valueLabel3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var valueLabel4: UILabel!
    @IBOutlet var widgetImageView: UIImageView!
    
    
    var paguthi_Id = String()
    var From = String()
    var totalCounts = String()
    /*Get CM Data */
    let presenter = ConstituentMemberPresenter(constituentMemberService: ConstituentMemberService())
    /*Get TM Data */
    let presenterTm = TotalMeetingPresenter(totalMeetingService: TotalMeetingService())
    /*Get TG Data */
    let presenterTG = TotalGreviancesPresenter(totalGreviancesSerVice: TotalGreviancesSerVice())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if From == "Cm"
        {
            self.CallAPICM()
        }
        else if From == "Tm"
        {
            self.CallAPITM()
        }
        else
        {
            self.CallAPITG ()
        }
    }
    
    func CallAPICM ()
    {
        presenter.attachView(view: self)
        presenter.getConstituentMember(paguthi: paguthi_Id)
    }
    
    func CallAPITM ()
    {
        presenterTm.attachView(view: self)
        presenterTm.getTotalMeeting(paguthi: paguthi_Id)
    }
    
    func CallAPITG ()
    {
        presenterTG.attachView(view: self)
        presenterTG.getTotalGreviances(paguthi: paguthi_Id)
    }
    
    func SetDataCM (member_count: Int, male_count: Int, female_count: Int, voterid_count: Int, aadhaar_count: Int)
    {
        self.widgetImageView.image = UIImage(named: "Cm.png")
        self.titleLabel.text = String (format: "%@ %@", "Constituent Members - " ,GlobalVariables.shared.constituent_MemberCount)
        self.label1.text = "Total Male"
        self.label2.text = "Total Female"
        self.label3.text = "No. of Voter ID"
        self.label4.text = "No. of Aadhaar Card"
        
        self.valueLabel1.text = String (male_count)
        self.valueLabel2.text = String (female_count)
        self.valueLabel3.text = String (voterid_count)
        self.valueLabel4.text = String (aadhaar_count)
    }
    
    func SetDataTM (meeting_count: Int, requested_count: Int, completed_count: Int)
    {
        self.widgetImageView.image = UIImage(named: "Tm.png")
        self.titleLabel.text = String (format: "%@ %@", "Total Meetings - ",GlobalVariables.shared.totalMeetingsCount)
        self.label1.text = "Meeting Requested"
        self.label2.text = "Meeting Completed"
        self.label3.isHidden = true
        self.label4.isHidden = true
        
        self.valueLabel1.text = String (requested_count)
        self.valueLabel2.text = String (completed_count)
        self.valueLabel3.isHidden = true
        self.valueLabel4.isHidden = true
    }
    
    func SetDataTG (grievance_count: Int, enquiry_count: Int, petition_count: Int, processing_count: Int, completed_count: Int)
    {
        self.widgetImageView.image = UIImage(named: "Tg.png")
        self.titleLabel.text = String (format: "%@ %@", "Total Meetings - ",GlobalVariables.shared.totalGrievancesCount)
        self.label1.text = "No. of Enquiry"
        self.label2.text = "No. of Petition"
        self.label3.text = "No. of Processing"
        self.label4.text = "No. of Completed"
        
        self.valueLabel1.text = String (enquiry_count)
        self.valueLabel2.text = String (petition_count)
        self.valueLabel3.text = String (processing_count)
        self.valueLabel4.text = String (completed_count)
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Widgets: ConstituentMemberView, TotalMeetingView, TotalGrevianceView
{
    func startLoadingTg() {
        //
    }
    
    func finishLoadingTg() {
        //
    }
    
    func setTg(grievance_count: Int?, enquiry_count: Int?, petition_count: Int?, processing_count: Int?, completed_count: Int?) {
        self.SetDataTG(grievance_count: grievance_count!, enquiry_count: enquiry_count!, petition_count: petition_count!, processing_count: processing_count!, completed_count: completed_count!)

    }
    
    func setEmptyTg(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    
    func startLoadingTm() {
        //
    }
    
    func finishLoadingTm() {
        //
    }
    
    func setTm(meeting_count: Int?, requested_count: Int?, completed_count: Int?) {
         self.SetDataTM (meeting_count: meeting_count!, requested_count: requested_count!, completed_count: completed_count!)
    }
    
    func setEmptyTm(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    
    
    func startLoadingCm() {
        //
    }
    
    func finishLoadingCm() {
        //
    }
    
    func setCm(member_count: Int?, male_count: Int?, female_count: Int?, voterid_count: Int?, aadhaar_count: Int?) {
        self.SetDataCM(member_count: member_count!, male_count: male_count!, female_count: female_count!, voterid_count: voterid_count!, aadhaar_count: aadhaar_count!)
         
    }
    
    func setEmptyCm(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
    }
    
    
}
