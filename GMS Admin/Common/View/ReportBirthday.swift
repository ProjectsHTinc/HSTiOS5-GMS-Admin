//
//  ReportBirthday.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

let reportBirthdayUrl = "apiios/reportBirthdaynew"

class ReportBirthday: UIViewController {
    
    /*Get Report BirthDay List*/
    let presenter = ReportBirthdayPresenter(reportBirthDayService:ReportBirthDayService())
    var reportData = [ReportBirthdayData]()
    var searchBar = UISearchController()
    let pickerView = UIPickerView()

    var monthArr = [String]()
    var monIDArr = [String]()
    var keyword = String()
    var selectedMonthID = String()
    
    var userNameArr = [String]()
    var dobArr = [String]()
    var mobileArr = [String]()
    var wishStatusArr = [String]()

    @IBOutlet var month: TextFieldWithImage!
    @IBOutlet var reportCount: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var baselIne: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.backgroundColor = UIColor.white
        self.tableView.isHidden = true
        self.reportCount.isHidden = true
        self.baselIne.isHidden = true
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        /*set Array Empty*/
        self.userNameArr.removeAll()
        self.dobArr.removeAll()
        self.mobileArr.removeAll()
        self.wishStatusArr.removeAll()
        //
        self.addCustomizedBackBtn(title:"  Birthday letter report")
        self.keyword = "no"
        self.monthArr = ["January","February","March","April","May","June","July","August","September","October","November","December"]
        self.monIDArr = ["01","02","03","04","05","06","07","08","09","10","11","12"]
        /*SetUp PickerView*/
        self.createPickerView()
    }
    
    @objc public override func rightButtonClick()
    {
        searchBar = UISearchController(searchResultsController: nil)
        // Set any properties (in this case, don't hide the nav bar and don't show the emoji keyboard option)
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.searchBar.keyboardType = UIKeyboardType.asciiCapable

        // Make this class the delegate and present the search
        self.searchBar.searchBar.delegate = self
        present(searchBar, animated: true, completion: nil)
    }
    
    func callAPI (url:String, select_month : String, keyword: String, offset:String, rowcount:String){
        presenter.attachView(view: self)
        presenter.getReportBirthday(url: url, select_month: select_month, keyword: keyword, offset: "0", rowcount: "50")
    }
    
    func createPickerView() {
           pickerView.dataSource = self
           pickerView.delegate = self
           pickerView.backgroundColor = UIColor.white
           pickerView.setValue(UIColor.black, forKeyPath: "textColor")
           month.inputView = pickerView
           let toolBar = UIToolbar()
           toolBar.sizeToFit()
           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))

           toolBar.setItems([doneButton,spaceButton,cancelButton], animated: true)
           toolBar.isUserInteractionEnabled = true
           toolBar.backgroundColor = UIColor.white
           toolBar.tintColor = UIColor(red: 45/255.0, green: 148/255.0, blue: 235/255.0, alpha: 1.0)
           month.inputAccessoryView = toolBar

    }
    
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true

    }
    
    @objc func cancel() {
          view.endEditing(true)
    }
    
    @objc func action() {
          let row = self.pickerView.selectedRow(inComponent: 0)
          self.pickerView.selectRow(row, inComponent: 0, animated: false)
          if self.month.isFirstResponder{
              month.text = self.monthArr[row]
              self.selectedMonthID = self.monIDArr[row]// selected item
          }
          view.endEditing(true)
    }
    
    @IBAction func search(_ sender: Any){
        
        guard CheckValuesAreEmpty () else {
              return
        }
        
        self.callAPI(url: reportBirthdayUrl, select_month: self.selectedMonthID, keyword: self.keyword, offset: "0", rowcount: "50")

    }
    
    func CheckValuesAreEmpty () -> Bool{
        
        guard Reachability.isConnectedToNetwork() == true else{
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return false
        }
        
        guard self.month.text?.count != 0  else {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: Globals.ConstituencyAlertMessage, complition: {
                
              })
             return false
         }
        
        
          return true
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_birthdaySearch")
        {
            let vc = segue.destination as! ReportBirthDaySearch
            vc.keyword = sender as! String
            vc.month = self.month.text!
        }
    }
    

}

extension ReportBirthday : ReportBirthdayView, UITableViewDelegate, UITableViewDataSource,  UIPickerViewDelegate, UIPickerViewDataSource , UISearchBarDelegate{
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        self.performSegue(withIdentifier: "to_birthdaySearch", sender: searchBar.text)
        self.searchBar.isActive = false
    }
    
    func startLoading() {
         //
    }
    
    func finishLoading() {
         //
    }
    
    func setReportBirthday(reportbday: [ReportBirthdayData]) {
        reportData = reportbday
        for items in reportData
        {
            let fullname = items.full_name
            let db = items.dob
            let mobile = items.mobile_no
            let status = items.birth_wish_status
            
            self.userNameArr.append(fullname!)
            self.dobArr.append(db!)
            self.mobileArr.append(mobile!)
            self.wishStatusArr.append(status!)
        }
        self.tableView.isHidden = false
        self.reportCount.isHidden = false
        self.reportCount.text = String(format: "%@ %@", String (GlobalVariables.shared.meetingAllCount),"Records")
        self.baselIne.isHidden = false
        /*Right Navigation Bar*/
        self.addrightButton(bg_ImageName:"ConstituentSearch")
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        if userNameArr.count == 0
        {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            })
            self.reportCount.text = String(format: "%@ %@", "0","Records")
            self.tableView.isHidden = true
        }
        else{
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            })
            self.reportCount.text = String(format: "%@ %@", String (GlobalVariables.shared.meetingAllCount),"Records")
            self.tableView.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return userNameArr.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportBirthdayCellTableViewCell
//         let data = reportData[indexPath.row]
           cell.userName.text = userNameArr[indexPath.row]
           let formatedDate = self.formattedDateFromString(dateString: dobArr[indexPath.row], withFormat: "dd-MM-YYYY")
           cell.db.text =  "D.O.B : " + formatedDate!
           cell.mobile.text = mobileArr[indexPath.row]
           cell.status.text = wishStatusArr[indexPath.row]
           if cell.status.text == "NotSend"{
             cell.status.textColor = UIColor(red: 204/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
           }
           else{
            cell.status.textColor = UIColor(red: 106/255.0, green: 168/255.0, blue: 79/255.0, alpha: 1.0)
           }
           return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if userNameArr.count == 0
        {
            let lastElement = userNameArr.count - 1
            if indexPath.row == lastElement
            {
                 print("came to last row")
                    self.callAPI(url: reportBirthdayUrl, select_month: self.selectedMonthID, keyword: self.keyword, offset: String(lastElement), rowcount: "50")
            }
        }
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 151
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return self.monthArr.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.monthArr[row] // dropdown item
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.month.text = self.monthArr[row]
    }
}
