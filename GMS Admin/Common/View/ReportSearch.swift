//
//  ReportSearch.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

let reportStatusSearch  = "apiios/reportStatussearch/"
let reportCategoerySearch  = "apiios/reportCategorysearch/"
let reportSubCategoerySearch  = "apiios/reportsubCategorysearch/"
let reportLocationSearch  = "apiios/reportLocationsearch/"

class ReportSearch: UIViewController {
    
    /*Get Report List*/
    let presenter = ReportPresenter(reportService: ReportService())
    var reportData = [ReportData]()
    
    var from = String()
    var paguthi = String()
    var status = String()
    var category = String()
    var sub_category = String()
    var fromdate = String()
    var todate = String()
    var keyword = String()

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
        
        if (from == "status")
        {
            self.callAPI(url: reportStatusSearch, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
        }
        else if (from == "categoery"){
            self.callAPI(url: reportCategoerySearch, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
        }
        else if (from == "subCate"){
            self.callAPI(url: reportSubCategoerySearch, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
        }
        else if (from == "location"){
            self.callAPI(url: reportLocationSearch, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
        }
    }
    
    func callAPI (url: String, From: String, from_date: String, to_date: String, status: String, paguthi: String,offset:String,rowCount:String,category: String, sub_category: String, keyword: String)
    {
        if (from == "status")
        {
            presenter.attachView(view: self)
            presenter.getReport(url: url, From: from, from_date: from_date, to_date: to_date, status: status, paguthi: paguthi, offset: offset, rowcount: rowCount, category: category, sub_category: sub_category, keyword: keyword)
        }
        else if (from == "categoery"){
            presenter.attachView(view: self)
            presenter.getReport(url: url, From: from, from_date: from_date, to_date: to_date, status: status, paguthi: paguthi, offset: offset, rowcount: rowCount, category: paguthi, sub_category: sub_category, keyword: keyword)
        }
        else if (from == "subCate"){
            presenter.attachView(view: self)
            presenter.getReport(url: url, From: from, from_date: from_date, to_date: to_date, status: status, paguthi: paguthi, offset: offset, rowcount: rowCount, category: paguthi, sub_category: paguthi, keyword: keyword)
        }
        else if (from == "location"){
            presenter.attachView(view: self)
            presenter.getReport(url: url, From: from, from_date: from_date, to_date: to_date, status: status, paguthi: paguthi, offset: offset, rowcount: rowCount, category: category, sub_category: sub_category, keyword: keyword)
        }
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

extension ReportSearch : ReportView, UITableViewDelegate, UITableViewDataSource{
    
    
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setReport(report: [ReportData]) {
        reportData = report
        self.reportCount.text = String(format: "%@ %@", String (GlobalVariables.shared.result_count),"Records")
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
        self.reportCount.text = String(format: "%@ %@","0","Records")
        self.tableView.isHidden = true
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return reportData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportListCell
            let data = reportData[indexPath.row]
            let type = data.grievance_type
            if type  == "P"{
                cell.pettionNumber.text = "Petition Number - " +  " " + data.petition_enquiry_no
            }
            else{
                cell.pettionNumber.text = "Enquiry Number - " +  " " + data.petition_enquiry_no
            }
            cell.mobile.text = data.mobile_no
            cell.docName.text = data.grievance_name
            cell.userName.text = data.full_name
            cell.subCategoeryName.text = data.created_by + "(\(data.role_name))"
            cell.status.text = data.status
            cell.createdby.text = data.grievance_date
            if cell.status.text == "PROCESSING"{
                cell.status.textColor = UIColor(red: 253/255, green: 166/255, blue: 68/255, alpha: 1.0)
            }
            else{
                cell.status.textColor = UIColor(red: 112/255, green: 173/255, blue: 71/255, alpha: 1.0)
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 210
        }
        
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           let totalRows = tableView.numberOfRows(inSection: indexPath.section)
           if indexPath.row == (totalRows - 1)
           {
               if totalRows >= 50
               {
                print("came to last row")
                if (from == "status"){
                    self.callAPI(url: reportStatus, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:String(totalRows),rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
                }
                else{
                    
                }
               }
           }
       }
}
