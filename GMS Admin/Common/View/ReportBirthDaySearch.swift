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
        self.callAPI (url: reportBirthdaySearchUrl, select_month: month, keyword: keyword, offset: "0", rowcount: "50")
    }
    
    func callAPI (url:String, select_month : String, keyword: String, offset:String, rowcount:String){
        presenter.attachView(view: self)
        presenter.getReportBirthday(url: url, select_month: select_month, keyword: keyword, offset: "0", rowcount: "50")
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
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
        self.tableView.isHidden = true
    }
}
