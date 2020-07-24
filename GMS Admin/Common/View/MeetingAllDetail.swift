//
//  MeetingAllDetail.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingAllDetail: UIViewController ,MeetingAllDetailView, UIPickerViewDelegate, UIPickerViewDataSource , MeetingAllDetailUpdateView{

    /*Get Meeting All List*/
    let presenter = MeetingAllDetailPresenter(meetingAllDetailService: MeetingAllDetailService())
    var data = [MeetingAllDetailData]()
    
    /*Get Meeting Update */
    let presenterUpdate = MeetingAllDetailUpdatePresenter(meetingAllDetailUpdateService: MeetingAllDetailUpdateService())
    
    let pickerView = UIPickerView()
    var statusArr = [String]()
    
    var meetingId = String()
    var userId = String()

    @IBOutlet var date: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var place: UILabel!
    @IBOutlet var meetingTitle: UILabel!
    @IBOutlet var detail: UILabel!
    @IBOutlet var status: TextFieldWithImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        self.statusArr = ["REQUESTED","COMPLETED"]
        self.createPickerView()
        self.callAPIMeetingDetail()

    }
    
    func callAPIMeetingDetail ()
    {
        presenter.attachView(view: self)
        presenter.getMeetingAllDetail(meeting_id: meetingId)
    }
    
    func createPickerView() {
           pickerView.dataSource = self
           pickerView.delegate = self
           status.inputView = pickerView
    }
    
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       status.inputAccessoryView = toolBar
    }
    @objc func action() {
          view.endEditing(true)
    }
    
    /*Picker View*/
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.statusArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return self.statusArr[row] // dropdown item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         status.text = self.statusArr[row] // selected item
         view.endEditing(true)
         self.callAPIMeetingUpdate(meeting_id: meetingId, user_id: GlobalVariables.shared.user_id, status: status.text!)
         
    }
    
    func callAPIMeetingUpdate(meeting_id: String, user_id: String, status: String){
        presenterUpdate.attachView(view: self)
        presenterUpdate.getMeetingAllDetail(meeting_id: meeting_id, user_id: user_id, status: status)
    }

    func startLoading() {
         self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setMeetingDetail(meetingdetail: [MeetingAllDetailData]) {
        data = meetingdetail
        self.name.text = data[0].full_name
        self.date.text = data[0].meeting_date
        self.place.text = data[0].paguthi_name + "(Paguthi)"
        self.meetingTitle.text = data[0].meeting_title
        self.detail.text = data[0].meeting_detail
        self.status.text = data[0].meeting_status
    }
    
    func setEmpty(errorMessage: String) {
        //
    }
    
    func setMeetingUpdate(msg: String, status: String) {
         
        if status == "Success"{
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: msg, complition: {
                self.navigationController?.popViewController(animated: true)
            })
        }
        else
        {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: msg, complition: {
            })
        }
    }
    
    @IBAction func update(_ sender: Any) {
        
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

