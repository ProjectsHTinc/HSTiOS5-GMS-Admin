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
        self.statusArr = ["Requested","Completed"]
        self.createPickerView()
        self.callAPIMeetingDetail()

    }
    
    func callAPIMeetingDetail ()
    {
        presenter.attachView(view: self)
        presenter.getMeetingAllDetail(meeting_id: meetingId,dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    func createPickerView() {
           pickerView.dataSource = self
           pickerView.delegate = self
           pickerView.backgroundColor = UIColor.white
           pickerView.setValue(UIColor.black, forKeyPath: "textColor")
           status.inputView = pickerView
        
           let toolBar = UIToolbar()
           toolBar.sizeToFit()
           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))

           toolBar.setItems([cancelButton,spaceButton,doneButton], animated: true)
           toolBar.isUserInteractionEnabled = true
           toolBar.tintColor = UIColor(red: 45/255.0, green: 148/255.0, blue: 235/255.0, alpha: 1.0)
           toolBar.isTranslucent = true
           status.inputAccessoryView = toolBar
    }
    
    @objc func cancel() {
          view.endEditing(true)
    }
    
    func dismissPickerView() {

    }
    @objc func action() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        if self.status.isFirstResponder{
            status.text = self.statusArr[row]// selected item
        }
        self.status.resignFirstResponder()
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
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//         status.text = self.statusArr[row] // selected item
//    }
    
    func callAPIMeetingUpdate(meeting_id: String, user_id: String, status: String){
        presenterUpdate.attachView(view: self)
        presenterUpdate.getMeetingAllDetail(meeting_id: meeting_id, user_id: user_id, status: status,dynamic_db:GlobalVariables.shared.dynamic_db)
    }

    func startLoading() {
         self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setMeetingDetail(meetingdetail: [MeetingAllDetailData]) {
        data = meetingdetail
        self.name.text = data[0].full_name.capitalized
        let formatedDate = self.formattedDateFromString(dateString: data[0].meeting_date, withFormat: "dd-MM-YYYY")
        self.date.text = formatedDate
        self.place.text = data[0].paguthi_name.capitalized + "(Paguthi)"
        self.meetingTitle.text = data[0].meeting_title.capitalized
        self.detail.text = data[0].meeting_detail.capitalized
        self.status.text = data[0].meeting_status.capitalized
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
        
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        self.callAPIMeetingUpdate(meeting_id: meetingId, user_id: GlobalVariables.shared.user_id, status: status.text!)
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format

            return outputFormatter.string(from: date)
        }

        return nil
    }
}

