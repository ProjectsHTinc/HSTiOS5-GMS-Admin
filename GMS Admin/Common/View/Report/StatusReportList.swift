//
//  StatusReportList.swift
//  GMS Admin
//
//  Created by HappysanziMac on 01/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//
import UIKit

let reportStatus  = "apiandroid/reportStatus/"

class StatusReportList: UIViewController,ReportView,UITableViewDelegate,UITableViewDataSource, ReportMeetingListView, ReportGrievanceListView, ReportBirthdayView, ReportFestivalListView, ReportVideoListView {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reportCount: UILabel!
    
    var from = String()
    var paguthi = String()
    var status = String()
    var category = String()
    var sub_category = String()
    var office = String()
    var fromdate = String()
    var todate = String()
    var keyword = String()
    var seekerId = String()
    var festival = String()
    
    let presenter = ReportPresenter(reportService: ReportService())
    var reportData = [ReportData]()
    
    let presenterVedio = ReportVideoListPresenter(reportVideoListService: ReportVideoListService())
    var VedioReportLiseData = [ReportVideoListData]()
    
    let presenterReportFestivalList = ReportFestivalListPresenter(reportFestivalListService: ReportFestivalListService())
    var reportFestivalListData = [ReportFestivalListData]()

    let presenterMeeting = ReportMeetingListPresenter(reportMeetingListService: ReportMeetingListService())
    var reportMeetingData = [ReportData]()
    
    let presenterGrievance = ReportGrievanceListPresenter(reportGrievanceListService: ReportGrievanceListService())
    var reportGrievanceData = [ReportGrievanceListData]()
    
    let presenterBirthday = ReportBirthdayPresenter(reportBirthDayService:ReportBirthDayService())
    var reportBirthdayData = [ReportBirthdayData]()
    
    var grievance_typeArr = [String]()
    var petition_enquiry_noArr = [String]()
    var mobile_noArr = [String]()
    var grievance_nameArr = [String]()
    var full_nameArr = [String]()
    var created_byArr = [String]()
    var statusArr = [String]()
    var role_nameArr = [String]()
    var grevDateArr = [String]()
    var addressArr = [String]()
    var fatherNameArr = [String]()
    var officeNameArr = [String]()
    var pincodeArr = [String]()
    var dobArr = [String]()
    var grievanceNameArr = [String]()
    var grievanceDateArr = [String]()
    var meetingDateArr = [String]()
    var meetingStatusArr = [String]()
    var doorNoArr = [String]()
    var month = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (from == "status")
        {
//            self.addCustomizedBackBtn(title:"  Status Report")
            self.callAPI(url: reportStatus, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
        }
        else if from == "meeting"{
            
            self.callAPI(url: reportMeeting, From: from, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
        }
        else if from == "grievance"{
            
            self.callAPIGrievance(url: reportGrievance, seeker_type_id: seekerId, from_date: fromdate, to_date: todate, status: status, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
        }
        else if from == "birthday"{
            
            self.callAPI(url: report_Birthday, From: from, from_date: fromdate, to_date: todate, status: month, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
        }
        else if from == "festival"{
            
            self.callAPI(url: festivalList, From: from, from_date: fromdate, to_date: todate, status: festival, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
        }
        else if from == "video"{
            
            self.callAPI(url: reportVideoList, From: from, from_date: fromdate, to_date: todate, status: festival, paguthi: paguthi,offset:"0",rowCount:"50",category: category, sub_category: sub_category, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
        }
    }
    
    func callAPIGrievance (url: String, seeker_type_id: String, from_date: String, to_date: String, status: String, paguthi: String,offset:String,rowCount:String,category: String, sub_category: String, keyword: String,dynamic_db:String,office:String){
        
        if from == "grievance"{
            presenterGrievance.attachView(view: self)
            presenterGrievance.getGrievanceReportList(url: url, seeker_type_id: seeker_type_id, from_date: from_date, to_date: to_date, status: festival, paguthi: paguthi, offset: offset, rowcount: rowCount, category: category, sub_category: sub_category, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
        }
    }
    
    func callAPI (url: String, From: String, from_date: String, to_date: String, status: String, paguthi: String,offset:String,rowCount:String,category: String, sub_category: String, keyword: String,dynamic_db:String,office:String)
    {
        if (from == "status")
        {
            presenter.attachView(view: self)
            presenter.getReport(url: url, From: from, from_date: from_date, to_date: to_date, status: status, paguthi: paguthi, offset: offset, rowcount: rowCount, category: category, sub_category: sub_category, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
        }
        else if from == "meeting"{
            presenterMeeting.attachView(view: self)
            presenterMeeting.getMeetingReportList(url: url, From: from, from_date: from_date, to_date: to_date, status: status, paguthi: paguthi, offset: offset, rowcount: rowCount, category: category, sub_category: sub_category, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
        }
        else if from == "birthday"{
            presenterBirthday.attachView(view: self)
            presenterBirthday.getReportBirthday(url: url, From: from, from_date: from_date, to_date: to_date, status: month, paguthi: paguthi, offset: offset, rowcount: rowCount, category: category, sub_category: sub_category, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
        }
        else if from == "festival"{
            presenterReportFestivalList.attachView(view: self)
            presenterReportFestivalList.getReportFestivalList(url: url, From: from, from_date: from_date, to_date: to_date, status: festival, paguthi: paguthi, offset: offset, rowcount: rowCount, category: category, sub_category: sub_category, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
        }
        else if from == "video"{
            presenterVedio.attachView(view: self)
            presenterVedio.getReportVideoList(url: url, From: from, from_date: from_date, to_date: to_date, status: festival, paguthi: paguthi, offset: offset, rowcount: rowCount, category: category, sub_category: sub_category, keyword: keyword,dynamic_db:GlobalVariables.shared.dynamic_db,office:office)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return full_nameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StatusReportCell
        
        if from == "status"{
          cell.name.text = full_nameArr[indexPath.row]
          cell.fatherName.text = "Father Name : \(fatherNameArr[indexPath.row])"
          cell.mobNum.text = mobile_noArr[indexPath.row]
          cell.dob.text = "DOB : \(dobArr[indexPath.row])"
          cell.status.text = statusArr[indexPath.row]
          cell.location.text = addressArr[indexPath.row]
            
            if statusArr.contains("SCHEDULED") {
                cell.status.textColor = UIColor(red: 233/255.0, green: 179/255.0, blue: 32/255.0, alpha: 1.0)
             }
            else if statusArr.contains("REQUESTED") {
                cell.status.textColor = UIColor(red: 255/255.0, green: 116/255.0, blue: 0/255.0, alpha: 1.0)
            }
            else if statusArr.contains("COMPLETED") {
                cell.status.textColor = UIColor(red: 67/255.0, green: 191/255.0, blue: 87/255.0, alpha: 1.0)
            }
        }
        else if from == "meeting" {
            cell.name.text = full_nameArr[indexPath.row]
            cell.fatherName.text = "Father Name : \(fatherNameArr[indexPath.row])"
            cell.mobNum.text = mobile_noArr[indexPath.row]
            cell.dob.text = full_nameArr[indexPath.row]
            
            cell.location.text = addressArr[indexPath.row]
            if statusArr.contains("SCHEDULED") {
               cell.status.textColor = UIColor(red: 233/255.0, green: 179/255.0, blue: 32/255.0, alpha: 1.0)
                cell.status.text = statusArr[indexPath.row]
            }
            else if statusArr.contains("REQUESTED") {
               cell.status.textColor = UIColor(red: 255/255.0, green: 116/255.0, blue: 0/255.0, alpha: 1.0)
               cell.status.text = statusArr[indexPath.row]
            }
            else if statusArr.contains("COMPLETED") {
               cell.status.textColor = UIColor(red: 67/255.0, green: 191/255.0, blue: 87/255.0, alpha: 1.0)
               cell.status.text = statusArr[indexPath.row]
            }
        }
        else if from == "grievance" {
            cell.name.text = full_nameArr[indexPath.row]
            cell.fatherName.text = "Father Name : \(fatherNameArr[indexPath.row])"
            cell.mobNum.text = mobile_noArr[indexPath.row]
            cell.dob.text = "DOB : \(full_nameArr[indexPath.row])"
            cell.status.text = meetingStatusArr[indexPath.row]
            cell.location.text = addressArr[indexPath.row]
            if meetingStatusArr.contains("SCHEDULED") {
               cell.status.textColor = UIColor(red: 233/255.0, green: 179/255.0, blue: 32/255.0, alpha: 1.0)
            }
            else if meetingStatusArr.contains("PENDING") {
               cell.status.textColor = UIColor(red: 255/255.0, green: 116/255.0, blue: 0/255.0, alpha: 1.0)
            }
            else if meetingStatusArr.contains("COMPLETED") {
               cell.status.textColor = UIColor(red: 67/255.0, green: 191/255.0, blue: 87/255.0, alpha: 1.0)
            }
        }
        else if from == "birthday" {
            cell.name.text = full_nameArr[indexPath.row]
            cell.fatherName.text = "Father Name : \(fatherNameArr[indexPath.row])"
            cell.mobNum.text = mobile_noArr[indexPath.row]
            cell.dob.text = "DOB : \(full_nameArr[indexPath.row])"
            cell.status.text = "Created by : \(created_byArr[indexPath.row])"
            cell.status.textColor = UIColor.black
            cell.status.backgroundColor = UIColor.white
            cell.location.text = addressArr[indexPath.row]
        }
        else if from == "video" {
            cell.name.text = full_nameArr[indexPath.row]
            cell.fatherName.text = "Father Name : \(fatherNameArr[indexPath.row])"
            cell.mobNum.text = mobile_noArr[indexPath.row]
            cell.dob.text = "DOB : \(full_nameArr[indexPath.row])"
            cell.status.text = "Created by : \(created_byArr[indexPath.row])"
            cell.status.textColor = UIColor.black
            cell.status.backgroundColor = UIColor.white
            cell.location.text = addressArr[indexPath.row]
        }
        return cell
    }

    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func setReport(report: [ReportData]) {
        
        let ReportData = report
        
        for items in ReportData
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
            let address = items.address
            let dob = items.dob
            let father = items.father_husband_name
            let pincode = items.pin_code
            let officeName = items.office_name
            
            self.grievance_typeArr.append(greType!)
            self.petition_enquiry_noArr.append(petNo)
            self.mobile_noArr.append(mob)
            self.grievance_nameArr.append(grevName.capitalized)
            self.full_nameArr.append(fullName.capitalized)
            self.created_byArr.append(createdby.capitalized)
            self.statusArr.append(status.capitalized)
            self.role_nameArr.append(role.capitalized)
            self.grevDateArr.append(grevDate)
            self.addressArr.append(address!)
            self.fatherNameArr.append(father!)
            self.officeNameArr.append(officeName!)
            self.pincodeArr.append(pincode!)
            self.dobArr.append(dob!)
            
        }
        self.reportCount.text = String(format: "%@ %@", String (GlobalVariables.shared.result_count),"Records")
//        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        
    }
    
    func setReport(report: [ReportMeetingListData]) {
        let ReportData = report
        
        for items in ReportData
        {
            let mob = items.mobile_no
            let fullName = items.full_name
            let createdby = items.created_by
            let address = items.address
            let dob = items.dob
            let father = items.father_husband_name
            let pincode = items.pin_code
            let officeName = items.office_name
            let meetDate = items.meeting_date
            let meetStatus = items.meeting_status
            let doorNo = items.door_no
            
            self.mobile_noArr.append(mob)
            self.full_nameArr.append(fullName.capitalized)
            self.created_byArr.append(createdby.capitalized)
            self.addressArr.append(address!)
            self.pincodeArr.append(pincode)
            self.dobArr.append(dob)
            self.fatherNameArr.append(father)
            self.officeNameArr.append(officeName)
            self.meetingDateArr.append(meetDate)
            self.statusArr.append(meetStatus)
            self.doorNoArr.append(doorNo)
        }
        self.reportCount.text = String(format: "%@ %@", String (GlobalVariables.shared.result_count),"Records")
//          self.tableView.isHidden = false
            self.tableView.reloadData()
    }
    
    func setReport(report: [ReportGrievanceListData]) {
        let GrievanceDataData = report
        
        for items in GrievanceDataData
        {
            let mob = items.mobile_no
            let fullName = items.full_name
            let createdby = items.created_by
            let address = items.address
            let dob = items.dob
            let father = items.father_husband_name
            let pincode = items.pin_code
            let officeName = items.office_name
            let grievanceDate = items.grievance_date
            let grievance_name = items.grievance_name
            let doorNo = items.door_no
            let status = items.status
            
            self.mobile_noArr.append(mob)
            self.full_nameArr.append(fullName.capitalized)
            self.created_byArr.append(createdby.capitalized)
            self.addressArr.append(address)
            self.pincodeArr.append(pincode)
            self.dobArr.append(dob)
            self.fatherNameArr.append(father)
            self.officeNameArr.append(officeName)
            self.grievanceNameArr.append(grievance_name)
            self.grievanceDateArr.append(grievanceDate)
            self.doorNoArr.append(doorNo)
            self.meetingStatusArr.append(status)
            
        }
        self.tableView.reloadData()
     }
    
    func setReportBirthday(reportbday: [ReportBirthdayData]) {
        
        reportBirthdayData = reportbday
        
        for datas in reportBirthdayData {
            let dob = datas.dob
            let fullName = datas.full_name
            let createdby = datas.send_on
            let address = datas.address
            let father = datas.father_husband_name
            let pincode = datas.pin_code
//            let emailId = datas.email_id
            let mobNum = datas.mobile_no
            let doorNo = datas.door_no
            
            self.mobile_noArr.append(mobNum!)
            self.full_nameArr.append(fullName!)
            self.created_byArr.append(createdby!)
            self.addressArr.append(address!)
            self.pincodeArr.append(pincode!)
            self.dobArr.append(dob!)
            self.fatherNameArr.append(father!)
            self.doorNoArr.append(doorNo!)
        }
        self.tableView.reloadData()
    }
    
    func setReportFestivalList(reportFestivalList: [ReportFestivalListData]) {
        reportFestivalListData = reportFestivalList
        
    }
    
    func setReportVideoList(reportVideoList: [ReportVideoListData]) {
        VedioReportLiseData = reportVideoList
        for datas in VedioReportLiseData {
        let dob = datas.dob
        let fullName = datas.full_name
        let createdby = datas.created_at
        let address = datas.address
        let father = datas.father_husband_name
        let pincode = datas.pin_code
        let mobNum = datas.mobile_no
        let doorNo = datas.door_no
        
        self.mobile_noArr.append(mobNum!)
        self.full_nameArr.append(fullName!)
        self.created_byArr.append(createdby!)
        self.addressArr.append(address!)
        self.pincodeArr.append(pincode!)
        self.dobArr.append(dob!)
        self.fatherNameArr.append(father!)
        self.doorNoArr.append(doorNo!)
        }
        self.tableView.reloadData()
    }
 }
