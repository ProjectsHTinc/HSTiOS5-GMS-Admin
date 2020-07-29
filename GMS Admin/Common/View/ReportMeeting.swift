//
//  ReportMeeting.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

let reportMeetingUrl = "apiios/reportMeetingsnew"

class ReportMeeting: UIViewController {
    
    /*Get Report List*/
    let presenter = ReportMeetingPresenter(reportMeetingService: ReportMeetingService())
    var reportData = [ReportMeetingData]()
    
    var searchBar = UISearchController()

    var fromdate = String()
    var todate = String()
    var keyword = String()

    @IBOutlet var meetingCount: UILabel!
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
        self.addCustomizedBackBtn(title:"  Meeting report")
        /*Right Navigation Bar*/
        self.addrightButton(bg_ImageName:"ConstituentSearch")
        self.keyword = "no"
        self.callAPI(url: reportMeetingUrl,from_date: fromdate, to_date: todate, offset:"0",rowCount:"50", keyword: keyword)
    }
    
    func callAPI (url: String, from_date: String, to_date: String, offset:String,rowCount:String,keyword: String)
    {
        presenter.attachView(view: self)
        presenter.getReportMeeting(url: url, keyword: keyword, from_date: from_date, to_date: to_date, offset: offset, rowcount: rowCount)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_reportMeetingSearch"){
            let vc = segue.destination as! ReportMeetingSearch
            vc.fromdate = fromdate
            vc.todate = todate
            vc.keyword = sender as! String
        }
    }
    

}

extension ReportMeeting : ReportMeetingView ,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        
        self.performSegue(withIdentifier: "to_reportMeetingSearch", sender: searchBar.text!)
        self.searchBar.isActive = false

    }
    
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setReport(report: [ReportMeetingData]) {
        reportData = report
        self.meetingCount.text = String(GlobalVariables.shared.meetingAllCount) + " Meetings"
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
        self.meetingCount.text = String(format: "%@ %@","0","Meetings")
        self.tableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return reportData.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MeetingAllCell
           let meetingData = reportData[indexPath.row]
           cell.name.text = meetingData.full_name
           cell.date.text = meetingData.meeting_date
           cell.paguthi.text = meetingData.paguthi_name + "(Paguthi)"
           cell.title.text = meetingData.meeting_title
           cell.status.text = meetingData.meeting_status
           cell.createdBy.text = meetingData.created_by
           return cell
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 184
    }
       
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           let totalRows = tableView.numberOfRows(inSection: indexPath.section)
           if indexPath.row == (totalRows - 1)
           {
               if totalRows >= 50
               {
                 print("came to last row")
                 self.callAPI(url: reportMeetingUrl,from_date: fromdate, to_date: todate, offset:String(totalRows),rowCount:"50", keyword: keyword)

               }
    
           }
    }
    
}
