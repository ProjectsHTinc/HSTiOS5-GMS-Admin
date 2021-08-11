//
//  RequestedViewController.swift
//  Constituent
//
//  Created by HappysanziMac on 15/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class RequestedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
       var meeting_Title = String()
       var meeting_Discrption = String()
       var meeting_Date = String()
       var meetingCreate  = String()
       var meeting_status = [String]()
       var meeting_TitleArr = [String]()
       var meeting_DiscrptionArr = [String]()
       var meeting_DateArr = [String]()
       var meetingCreateArr = [String]()
       var selectedconstitunecyId = String()
       var from = String()

       let meetingPresener = MeetingPresenter(meetingService: MeetingService())
       var meetingeData = [MeetingData]()
    
    
       @IBOutlet var tableView: UITableView!
       
       override func viewDidLoad() {
           super.viewDidLoad()

          from = "requested"
           guard checkInterConnection () else {
               return
           }
           self.view.isHidden = false
   //        self.addCustomizedBackBtn(title:"  Meeting")
           /*set delegates*/
           self.tableView?.delegate = self
           self.tableView?.dataSource = self
           self.tableView?.backgroundColor = .white
           /*Call API*/
           self.callAPI()
           self.selectedconstitunecyId = GlobalVariables.shared.selectedConstiuencyIdMeeting
//          print(GlobalVariables.shared.selectedConstiuencyIdMeeting)
       }
       
       func setMeeting(meeting: [MeetingData]) {
            meetingeData = meeting
           print(meetingeData.count)
           
           self.meeting_status.removeAll()
           self.meeting_status.removeAll()
           self.meeting_status.removeAll()
           self.meeting_status.removeAll()
           
           for data in meetingeData {
               
               let statusArr = data.meeting_status
               let onDateArr = data.meeting_date
               let titleArr = data.meeting_title
//               let meetCraetedDate = data.created_at
               let meetingDescription = data.meeting_detail
               
               if statusArr.contains("REQUESTED") {
                   
               self.meeting_status.append(statusArr)
               self.meeting_DateArr.append(onDateArr)
               self.meeting_TitleArr.append(titleArr)
//               self.meetingCreateArr.append(meetCraetedDate)
               self.meeting_DiscrptionArr.append(meetingDescription)
               }
             }
            self.tableView?.reloadData()
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
//           meetingPresener.getMeeting(user_id: GlobalVariables.shared.user_id,dynamic_db:GlobalVariables.shared.dynamic_Db)
        meetingPresener.getMeeting(constituency_id: selectedconstitunecyId, offset: "0", rowcount:"50",dynamic_db:GlobalVariables.shared.dynamic_db)
        
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return meeting_status.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RequestedCell

           cell.meetingTitle.text = String(meeting_TitleArr[indexPath.row])
//           cell.meetingOnDate.text = String(meeting_DateArr[indexPath.row])
           cell.cretaeDate.text = String(meetingCreateArr[indexPath.row])
           cell.selectionStyle = .none
           return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        self.meeting_Title = meeting_TitleArr[indexPath.row]
        self.meeting_Discrption = meeting_DiscrptionArr[indexPath.row]
        self.meeting_Date = meetingCreateArr[indexPath.row]
       
        self.performSegue(withIdentifier: "toMeetingDetail", sender: self)
      }
   }

   extension RequestedViewController: MeetingView
   {
       func startLoading() {
            
           self.view.activityStartAnimating()
       }
       
       func finishLoading() {
           
           self.view.activityStopAnimating()
       }
    
       func setEmpty(errorMessage: String) {
             AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
             })
            self.tableView.isHidden = true
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "toMeetingDetail")
        {
            let vc = segue.destination as! MeetingDetail
            vc.meeting_Title = self.meeting_Title
            vc.meeting_Discrption = self.meeting_Discrption
//            vc.meetingCreateDate = self.meeting_Date
//            vc.from = from
//            vc.newsDetails = self.news_Details
        }
    }
   }
