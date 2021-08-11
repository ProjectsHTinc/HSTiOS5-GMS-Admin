//
//  ReportStaff.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ReportStaff: UIViewController, ReportStaffView ,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    /*Get Report Staff List*/
    let presenter = ReportStaffPresenter(reportStaffService: ReportStaffService())
    var reportData = [ReportStaffData]()
    var filterdArr = [ReportStaffData]()
    
    var fromdate = String()
    var todate = String()
    var searchBar = UISearchController()
    
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
        self.addCustomizedBackBtn(title:"  Staff Report")
        /*Right Navigation Bar*/
        self.addrightButton(bg_ImageName:"ConstituentSearch")
        self.callAPI()
    }
    
    @objc public override func rightButtonClick()
    {
        searchBar = UISearchController(searchResultsController: nil)
        // Set any properties (in this case, don't hide the nav bar and don't show the emoji keyboard option)
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.searchBar.keyboardType = UIKeyboardType.asciiCapable
        searchBar.searchResultsUpdater = self
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.definesPresentationContext = true

        // Make this class the delegate and present the search
        self.searchBar.searchBar.delegate = self
        present(searchBar, animated: true, completion: nil)
    }
    
    func callAPI ()
    {
        presenter.attachView(view: self)
        presenter.getReportStaff(from_date: fromdate, to_date: todate,dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setReportStaff(reportstaff: [ReportStaffData]) {
        reportData = reportstaff
        filterdArr = reportData
        self.reportCount.text = String(GlobalVariables.shared.meetingAllCount) + " Staff"
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
        self.reportCount.text = "0" + " Staff"
        self.tableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.isActive && searchBar.searchBar.text != "" {
            return filterdArr.count
        }
        else{
            return reportData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportStaffCell
        if searchBar.isActive && searchBar.searchBar.text != "" {
            let data = filterdArr[indexPath.row]
            cell.userName.text = data.full_name?.capitalized
            cell.total.text = data.total
            cell.active.text = data.active
            cell.inactive.text = data.inactive
        }
        else{
            let data = reportData[indexPath.row]
            cell.userName.text = data.full_name?.capitalized
            cell.total.text = data.total
            cell.active.text = data.active
            cell.inactive.text = data.inactive
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 136
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text?.lowercased()
        if searchText?.count != 0
        {
           filterdArr = reportData.filter({( model : ReportStaffData) -> Bool in
            return model.full_name!.lowercased().contains(searchText!.lowercased())||model.total!.lowercased().contains(searchText!.lowercased())
                || model.active!.lowercased().contains(searchText!.lowercased())||model.inactive!.lowercased().contains(searchText!.lowercased())
            })
        }
        tableView.reloadData()
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
