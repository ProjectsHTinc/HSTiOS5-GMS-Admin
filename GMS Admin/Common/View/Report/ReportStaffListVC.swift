//
//  ReportStaffListVC.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class ReportStaffListVC: UIViewController,UITableViewDelegate,UITableViewDataSource, ReportStaffListView {
   
    @IBOutlet weak var tableView: UITableView!
        
    let presenter = ReportStaffListPresenter(reportStaffListService: ReportStaffListService())
    var reportData = [ReportStaffListData]()
    
    var fromdate = String()
    var todate = String()
    var full_nameArr = [String]()
    var total_broadcastArr = [String]()
    var total_consArr = [String]()
    var total_gArr = [String]()
    var total_vArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.callAPI(url: reportStaffList, from_date: fromdate, to_date: todate, dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    func callAPI (url: String ,from_date: String, to_date: String,dynamic_db:String) {
        
        presenter.attachView(view: self)
        presenter.getReportStaffList(url: url, from_date: from_date,to_date: to_date,dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return full_nameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportStaffListCell
        cell.lbl1.text = total_consArr[indexPath.row]
        cell.lbl2.text = total_vArr[indexPath.row]
        cell.lbl3.text = total_gArr[indexPath.row]
        cell.lbl4.text = total_broadcastArr[indexPath.row]
        cell.nameLbl.text = full_nameArr[indexPath.row]
        return cell
    }

    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func setReportStaffList(reportStaffoList: [ReportStaffListData]) {
        reportData = reportStaffoList
        
        for items  in reportData {
            let name = items.full_name
            let brodcost = items.total_broadcast
            let const = items.total_cons
            let grievance = items.total_g
            let vedio = items.total_v
            
            self.full_nameArr.append(name!)
            self.total_broadcastArr.append(brodcost!)
            self.total_consArr.append(const!)
            self.total_gArr.append(grievance!)
            self.total_vArr.append(vedio!)
        }
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        
    }
}

