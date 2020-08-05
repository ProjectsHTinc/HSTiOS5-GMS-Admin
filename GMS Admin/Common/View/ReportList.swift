//
//  ReportList.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

let reportStatus  = "apiios/reportStatusnew/"
let reportCategoery  = "apiios/reportCategorynew/"
let reportSubCategoery  = "apiios/reportsubCategorynew/"
let reportLocation  = "apiios/reportLocationnew/"

class ReportList: UIViewController {
    
    var searchBar = UISearchController()

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
    
    var grievance_typeArr = [String]()
    var petition_enquiry_noArr = [String]()
    var mobile_noArr = [String]()
    var grievance_nameArr = [String]()
    var full_nameArr = [String]()
    var created_byArr = [String]()
    var statusArr = [String]()
    var role_nameArr = [String]()
    var grevDateArr = [String]()

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
        /*Right Navigation Bar*/
        self.addrightButton(bg_ImageName:"ConstituentSearch")
        self.keyword = "no"
        /*Set Array's Empty*/
        self.grievance_typeArr.removeAll()
        self.petition_enquiry_noArr.removeAll()
        self.mobile_noArr.removeAll()
        self.full_nameArr.removeAll()
        self.created_byArr.removeAll()
        self.statusArr.removeAll()
        self.role_nameArr.removeAll()
        self.grevDateArr.removeAll()
        //
        if (from == "status")
        {
            self.addCustomizedBackBtn(title:"  Status Report")
            self.callAPI(url: reportStatus, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
        }
        else if (from == "categoery"){
            self.addCustomizedBackBtn(title:"  Category Report")
            self.callAPI(url: reportCategoery, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
        }
        else if (from == "subCate"){
            self.addCustomizedBackBtn(title:"  Sub category Report")
            self.callAPI(url: reportSubCategoery, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
        }
        else if (from == "location"){
            self.addCustomizedBackBtn(title:"  Location Report")
            self.callAPI(url: reportLocation, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
        }

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
        if (segue.identifier == "to_reportSearch"){
            let vc = segue.destination as! ReportSearch
            vc.from = from
            vc.paguthi = paguthi
            vc.paguthi = paguthi
            vc.category = category
            vc.sub_category = sub_category
            vc.fromdate = fromdate
            vc.todate = todate
            vc.keyword = sender as! String
            vc.status = status
        }
    }
    

}

extension ReportList : ReportView, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        
        self.performSegue(withIdentifier: "to_reportSearch", sender: searchBar.text!)
        self.searchBar.isActive = false

    }
    
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setReport(report: [ReportData]) {
        reportData = report
        for items in reportData
        {
            let greType = items.grievance_type
            let petNo = items.petition_enquiry_no
            let mob = items.mobile_no
            let grevName = items.grievance_name
            let fullName = items.full_name
            let createdby = items.created_by
            let status = items.status
            let role = items.role_name
            let grevDate = items.grievance_date
            
            self.grievance_typeArr.append(greType!)
            self.petition_enquiry_noArr.append(petNo)
            self.mobile_noArr.append(mob)
            self.grievance_nameArr.append(grevName)
            self.full_nameArr.append(fullName)
            self.created_byArr.append(createdby)
            self.statusArr.append(status)
            self.role_nameArr.append(role)
            self.grevDateArr.append(grevDate)
        }
        self.reportCount.text = String(format: "%@ %@", String (GlobalVariables.shared.result_count),"Records")
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        if grievance_nameArr.count == 0{
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            })
            self.reportCount.text = String(format: "%@ %@","0","Records")
            self.tableView.isHidden = true
        }
        else{
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            })
            self.reportCount.text = String(format: "%@ %@",String (GlobalVariables.shared.result_count),"Records")
            self.tableView.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grievance_nameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportListCell
//          let data = reportData[indexPath.row]
        let type = grievance_typeArr[indexPath.row]
        if type  == "P"{
            cell.pettionNumber.text = "Petition Number - " +  " " + petition_enquiry_noArr[indexPath.row]
        }
        else{
            cell.pettionNumber.text = "Enquiry Number - " +  " " + petition_enquiry_noArr[indexPath.row]
        }
        cell.mobile.text = mobile_noArr[indexPath.row]
        cell.docName.text = grievance_nameArr[indexPath.row]
        cell.userName.text = full_nameArr[indexPath.row]
        cell.subCategoeryName.text = "Created by" + " " + created_byArr[indexPath.row] + "(\(role_nameArr[indexPath.row]))"
        cell.status.text = statusArr[indexPath.row]
        let formatedDate = self.formattedDateFromString(dateString: grevDateArr[indexPath.row], withFormat: "dd-MM-YYYY")
        cell.createdby.text = formatedDate
        
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
       if grievance_nameArr.count > 20
       {
            let lastElement = grievance_nameArr.count - 1
            if indexPath.row == lastElement
            {
                let lE = lastElement + 1
                if (from == "status")
                {
                    self.callAPI(url: reportStatus, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:String(lE),rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
                }
                else if (from == "categoery"){
                    self.callAPI(url: reportCategoery, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:String(lE),rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
                }
                else if (from == "subCate"){
                    self.callAPI(url: reportSubCategoery, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:String(lE),rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
                }
                else if (from == "location"){
                    self.callAPI(url: reportLocation, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:String(lE),rowCount:"50",category: category, sub_category: sub_category, keyword: keyword)
                }
            }
       }
   }
}
