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
    var keyword = String()
    
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
        self.keyword = "no"
        self.monthArr = ["January","February","March","April","May","June","July","August","September","October","November","December"]
        /*SetUp PickerView*/
        self.createPickerView()
        /*Right Navigation Bar*/
        self.addrightButton(bg_ImageName:"ConstituentSearch")

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
           month.inputView = pickerView
    }
    
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       month.inputAccessoryView = toolBar

    }
    
    @objc func action() {
          view.endEditing(true)
    }
    
    @IBAction func search(_ sender: Any){
        
        guard CheckValuesAreEmpty () else {
              return
        }
        
        self.callAPI(url: reportBirthdayUrl, select_month: self.month.text!, keyword: self.keyword, offset: "0", rowcount: "50")

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
        guard CheckValuesAreEmpty () else {
              return
        }
        
        self.performSegue(withIdentifier: "to_birthdaySearch", sender: searchBar.text!)
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
        self.tableView.isHidden = false
        self.reportCount.isHidden = false
        self.baselIne.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
        self.tableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return reportData.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportBirthdayCellTableViewCell
           let data = reportData[indexPath.row]
           cell.userName.text = data.full_name
           cell.db.text =  "D.O.B : " + data.dob!
           cell.mobile.text = data.mobile_no
           cell.status.text = data.birth_wish_status
           return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        if indexPath.row == (totalRows - 1)
        {
            if totalRows >= 50
            {
             print("came to last row")
                self.callAPI(url: reportBirthdayUrl, select_month: self.month.text!, keyword: self.keyword, offset: String(totalRows), rowcount: "50")
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
        self.callAPI(url: reportBirthdayUrl, select_month: self.month.text!, keyword: self.keyword, offset: "0", rowcount: "50")
    }
}
