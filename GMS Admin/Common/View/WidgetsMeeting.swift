//
//  WidgetsMeeting.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class WidgetsMeeting: UIViewController,TotalMeetingView {
    
    @IBOutlet weak var widgetMeeting: UILabel!
    @IBOutlet weak var requestedCount: UILabel!
    @IBOutlet weak var completedCount: UILabel!
    @IBOutlet weak var requestedCountPercentage: UILabel!
    @IBOutlet weak var completedCountpercentage: UILabel!
    
    var paguthi_Id = String()
    let presenterTm = TotalMeetingPresenter(totalMeetingService: TotalMeetingService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.CallAPITM()
    }
    
    func CallAPITM ()
    {
        presenterTm.attachView(view: self)
        presenterTm.getTotalMeeting(paguthi: paguthi_Id, from_date: GlobalVariables.shared.widgetFromDate, to_date: GlobalVariables.shared.widgetToDate,dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    func setTm(total_meeting: String?, request_count_percentage: String?, request_count: String?, complete_count: String?, complete_count_percentage: String?) {
        
        widgetMeeting.text = String("Meeting Count - \(total_meeting!)")
        requestedCount.text = String(request_count!)
        completedCount.text = String(complete_count!)
        requestedCountPercentage.text = String("Requested(\(request_count_percentage!)%)")
        completedCountpercentage.text = String("Completed (\(complete_count_percentage!)%)")

    }
    
    
    func startLoadingTm() {
//
    }
    
    func finishLoadingTm() {
//
    }
   
    
    func setEmptyTm(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    
    
    @IBAction func dissmiss(_ sender: Any) {
        
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
