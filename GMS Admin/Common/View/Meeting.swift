//
//  Meeting.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Meeting: UIViewController {
    
    let meetingPresener = MeetingPresenter(meetingService: MeetingService())
    var meetingeData = [MeetingData]()
    
    var meeting_Title = String()
    var meeting_Discrption = String()
    var meeting_Date = String()

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Check Internet Connection*/
        guard checkInterConnection () else {
            return
        }
        
        self.view.isHidden = false
        self.addCustomizedBackBtn(title:"  Meeting")
        /*set delegates*/
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.backgroundColor = .white
        /*Call API*/
        self.callAPI()
    }
    
    func checkInterConnection () -> Bool
    {
        guard Reachability.isConnectedToNetwork() == true else{
              self.view.isHidden = true
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
              return false
        }
              return true
    }

    func callAPI()
    {
        meetingPresener.attachView(view: self)
        meetingPresener.getMeeting(user_id: GlobalVariables.shared.user_id)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "to_MeetingDetails")
        {
            let vc = segue.destination as! MeetingDetail
            vc.meeting_Title = meeting_Title
            vc.meeting_Discrption = meeting_Discrption
            vc.meeting_Date = meeting_Date

        }
    }
    

}

extension Meeting: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetingeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MeetingCell
        let data = meetingeData[indexPath.row]
        cell.meetingTitle.text = data.meeting_title
        cell.meetingdate.text = data.meeting_date
        cell.meetingStatus.text = data.meeting_status
        
        if cell.meetingStatus.text == "REQUESTED" || cell.meetingStatus.text == "PROCESSING"
        {
            cell.meetingTitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
            cell.meetingdate.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
            cell.titleImageGroup.image = UIImage(named: "meetingGroupIcon")
            cell.calenderImage.image = UIImage(named: "meetingDate")
            cell.meetingStatus.backgroundColor = UIColor(red: 253.0/255, green: 166.0/255, blue: 68.0/255, alpha: 1.0)
        }
        else
        {
            cell.meetingTitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            cell.meetingdate.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            cell.titleImageGroup.image = UIImage(named: "meetingCompleted")
            cell.calenderImage.image = UIImage(named: "meetingCompletedDate")
            cell.meetingStatus.backgroundColor =  UIColor(red: 112.0/255, green: 173.0/255, blue: 71.0/255, alpha: 0.6)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = meetingeData[indexPath.row]
        self.meeting_Title = data.meeting_title
        self.meeting_Discrption = data.meeting_detail
        self.meeting_Date = data.meeting_date
        self.performSegue(withIdentifier: "to_MeetingDetails", sender: self)
    }
    
}

extension Meeting: MeetingView
{
    func startLoading() {
         
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        
        self.view.activityStopAnimating()
    }
    
    func setMeeting(meeting: [MeetingData]) {
         meetingeData = meeting
         self.tableView?.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
          AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
          })
         self.tableView.isHidden = true
    }
    
}
