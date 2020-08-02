//
//  ReportBirthDaySearch.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

let reportBirthdaySearchUrl = "apiios/reportBirthdaysearch"

class ReportBirthDaySearch: UIViewController {
    
    /*Get Report BirthDay List*/
    let presenter = ReportBirthdayPresenter(reportBirthDayService:ReportBirthDayService())
    var reportData = [ReportBirthdayData]()

    var keyword = String()
    var month = String()
    
    var userNameArr = [String]()
    var dobArr = [String]()
    var mobileArr = [String]()
    var wishStatusArr = [String]()

    @IBOutlet var reportCount: UILabel!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.backgroundColor = UIColor.white
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
        self.callAPI (url: reportBirthdaySearchUrl, select_month: month, keyword: keyword, offset: "0", rowcount: "50")
    }
    
    func callAPI (url:String, select_month : String, keyword: String, offset:String, rowcount:String){
        presenter.attachView(view: self)
        presenter.getReportBirthday(url: url, select_month: select_month, keyword: keyword, offset: offset, rowcount: rowcount)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ReportBirthDaySearch : ReportBirthdayView, UITableViewDelegate, UITableViewDataSource{

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
           if cell.status.text == "NotSend"{
              cell.status.textColor = UIColor(red: 204/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
           }
           else{
              cell.status.textColor = UIColor(red: 106/255.0, green: 168/255.0, blue: 79/255.0, alpha: 1.0)
           }
           return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        if indexPath.row == (totalRows - 1)
        {
            if totalRows >= 50
            {
                print("came to last row")
                self.callAPI(url: reportBirthdaySearchUrl, select_month:self.month, keyword: self.keyword, offset: String(totalRows), rowcount: "50")
            }
        }
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 151
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
        self.reportCount.text = String(format: "%@ %@", String (GlobalVariables.shared.result_count),"Records")
        self.tableView.isHidden = false
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
            self.reportCount.text = String(format: "%@ %@", String (GlobalVariables.shared.result_count),"Records")
            self.tableView.isHidden = false
        }
    }
}
