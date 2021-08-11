//
//  ConstituentListVC.swift
//  GMS Admin
//
//  Created by HappysanziMac on  05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentListVC: UIViewController,UITableViewDelegate,UITableViewDataSource, ReportConstituentListView{
 
    let presenter = ReportConstituentListPresenter(reportConstituentListService: ReportConstituentListService())
    var reportData = [ReportConstituentListData]()
    
    var paguthi = String()
    var status = String()
    var whatsap = String()
    var emailId = String()
    var voterId = String()
    var dob = String()
    var phoneNum = String()
    var office = String()
    var keyword = String()
    var nav_title = String()

    var mobile_noArr = [String]()
    var full_nameArr = [String]()
    var created_byArr = [String]()
    var addressArr = [String]()
    var fatherNameArr = [String]()
    var officeNameArr = [String]()
    var pincodeArr = [String]()
    var dobArr = [String]()
    var doorNoArr = [String]()
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.callAPI(url: reportConstituent, whatsap: whatsap, emailId: emailId, voterId: voterId, paguthi: paguthi,offset:"0",rowCount:"50",dob: dob, phoneNum: phoneNum, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
//        self.navigationItem.title = nav_title
    }
    
    func callAPI (url: String, whatsap: String, emailId: String, voterId: String, paguthi: String,offset:String,rowCount:String,dob: String, phoneNum: String, keyword: String,dynamic_db:String,office:String){
        
        presenter.attachView(view: self)
        presenter.getReportConstituentList(url: url, whatsap: whatsap, emailId: emailId, voterId: voterId, paguthi: paguthi, offset: offset, rowCount: rowCount, dob: dob, phoneNum: phoneNum, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return full_nameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConstituentListCell
        cell.name.text = full_nameArr[indexPath.row]
        cell.fatherName.text = "Father Name : \(fatherNameArr[indexPath.row])"
        cell.mobNum.text = mobile_noArr[indexPath.row]
        cell.dob.text = "DOB : \(dobArr[indexPath.row])"
        cell.location.text = addressArr[indexPath.row]
        return cell
    }
    
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setReportConstituentList(reportConstituentList: [ReportConstituentListData]) {
        reportData = reportConstituentList
        for datas in reportData {
            
            let dob = datas.dob
            let fullName = datas.full_name
            let created_at = datas.created_at
            let address = datas.address
            let father = datas.father_husband_name
            let pincode = datas.pin_code
//            let emailId = datas.email_id
            let mobNum = datas.mobile_no
            let doorNo = datas.door_no
            
            self.mobile_noArr.append(mobNum!)
            self.full_nameArr.append(fullName!)
            self.created_byArr.append(created_at!)
            self.addressArr.append(address!)
            self.pincodeArr.append(pincode!)
            self.dobArr.append(dob!)
            self.fatherNameArr.append(father!)
            self.doorNoArr.append(doorNo!)
        }
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
      
    }
}
