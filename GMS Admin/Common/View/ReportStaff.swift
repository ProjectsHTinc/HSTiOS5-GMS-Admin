//
//  ReportStaff.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ReportStaff: UIViewController, ReportStaffView ,UITableViewDelegate, UITableViewDataSource {

    /*Get Report Staff List*/
    let presenter = ReportStaffPresenter(reportStaffService: ReportStaffService())
    var reportData = [ReportStaffData]()
    
    var fromdate = String()
    var todate = String()
    
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
        self.callAPI()
    }
    
    func callAPI ()
    {
        presenter.attachView(view: self)
        presenter.getReportStaff(from_date: fromdate, to_date: todate)
    }
    
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setReportStaff(reportstaff: [ReportStaffData]) {
        reportData = reportstaff
        self.tableView.isHidden = false
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportStaffCell
        let data = reportData[indexPath.row]
        cell.total.text = data.total
        cell.active.text = data.active
        cell.inactive.text = data.inactive
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 136
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
