//
//  MeetingAll.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SideMenu

let meetingUrl = "apiios/meetingRequestnew"

class MeetingAll: UIViewController {
    
    /*Get Meeting All List*/
    let presenter = MeetingAllPresenter(meetingAllService: MeetingAllService())
    var data = [MeetingAllData]()
    var searchBar = UISearchController()
    
    var fullNameArr = [String]()
    var meetingDateArr = [String]()
    var paguthiNameArr = [String]()
    var meetingTitleArr = [String]()
    var meetingStatusArr = [String]()
    var createdByArr = [String]()
    var meetingIdArr = [String]()

    @IBOutlet var baseLine: UILabel!
    @IBOutlet var meetingCount: UILabel!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Meeting"
        //setupSideMenu()
        /*Set Side menu*/
        self.sideMenuButton()
        /*Right Navigation Bar*/
        self.addrightButton(bg_ImageName:"ConstituentSearch")
        self.tableView.backgroundColor = UIColor.white
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        /*Set Empty Array*/
        self.fullNameArr.removeAll()
        self.meetingDateArr.removeAll()
        self.paguthiNameArr.removeAll()
        self.meetingTitleArr.removeAll()
        self.meetingStatusArr.removeAll()
        self.createdByArr.removeAll()
        self.meetingIdArr.removeAll()
        //
        self.callAPIMeetingAll(url: meetingUrl, keyword: "no", constituency_id: GlobalVariables.shared.constituent_Id, offset: "0", rowcount: "50")
    }
    
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        
        //SideMenuPresentationStyle.menuSlideIn
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    }
    
    func makeSettings() -> SideMenuSettings{
        var settings = SideMenuSettings()
        settings.allowPushOfSameClassTwice = false
        settings.presentationStyle = .menuSlideIn
        settings.presentationStyle.backgroundColor = .black
        settings.presentationStyle.presentingEndAlpha = 0.5
        settings.statusBarEndAlpha = 0
        return settings
    }
    
    func callAPIMeetingAll (url:String, keyword: String,constituency_id:String, offset: String, rowcount:String)
    {
        presenter.attachView(view: self)
        presenter.getMeetingAll(url:url, keyword: keyword,constituency_id: constituency_id, offset: offset, rowcount: rowcount)
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
    
    @objc public override func sideMenuButtonClick()
    {
        self.performSegue(withIdentifier: "to_sideMenu", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "meetingsearch")
        {
            let vc = segue.destination as! MeetingAllSearch
            vc.keyword = sender as! String
        }
        else if (segue.identifier == "to_meetingallDetail"){
                let vc = segue.destination as! MeetingAllDetail
                vc.meetingId = sender as! String
        }
//        else if (segue.identifier == "to_sideMenu")
//        {
//            guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
//            sideMenuNavigationController.settings = makeSettings()
//        }
    }
    

}

extension MeetingAll : MeetingAllDataView, UISearchBarDelegate ,  UITableViewDelegate, UITableViewDataSource
{
    func startLoading() {
         self.view.activityStartAnimating()
    }
    
    func finishLoading() {
         self.view.activityStopAnimating()
    }
    
    func setMeetingAll(meetingAll: [MeetingAllData]) {
        data = meetingAll
        for items in data
        {
            let fullName = items.full_name
            let meetingdate = items.meeting_date
            let paguthiName = items.paguthi_name
            let meetingTitle = items.meeting_title
            let meetingstatus = items.meeting_status
            let createdby = items.created_by
            let meetingId = items.id
            
            self.fullNameArr.append(fullName.capitalized)
            self.meetingDateArr.append(meetingdate)
            self.paguthiNameArr.append(paguthiName.capitalized)
            self.meetingTitleArr.append(meetingTitle.capitalized)
            self.meetingStatusArr.append(meetingstatus.capitalized)
            self.createdByArr.append(createdby.capitalized)
            self.meetingIdArr.append(meetingId)

        }
        self.meetingCount.text = String(GlobalVariables.shared.meetingAllCount) + " Meetings"
        self.tableView.isHidden = false
        self.meetingCount.isHidden = false
        self.baseLine.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        if meetingTitleArr.count == 0
        {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            })
            self.meetingCount.text = "0" + " Meetings"

            self.tableView.isHidden = true
        }
        else{
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            })
            self.meetingCount.text = String(GlobalVariables.shared.meetingAllCount) + " Meetings"
            self.tableView.isHidden = false
        }
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        
        self.performSegue(withIdentifier: "meetingsearch", sender: searchBar.text!)
        self.searchBar.isActive = false

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return meetingTitleArr.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MeetingAllCell
//         let meetingData = data[indexPath.row]
           cell.name.text = fullNameArr[indexPath.row]
           let formatedDate = self.formattedDateFromString(dateString: meetingDateArr[indexPath.row], withFormat: "dd-MM-YYYY")
           cell.date.text = formatedDate
           cell.paguthi.text = paguthiNameArr[indexPath.row]
           //+ "(Paguthi)"
           cell.title.text = meetingTitleArr[indexPath.row]
           cell.status.text = meetingStatusArr[indexPath.row]
           cell.createdBy.text = "Created by - " + createdByArr[indexPath.row]
           return cell
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 184
    }
       
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           if fullNameArr.count > 20
           {
              let lastElement = fullNameArr.count - 1
               if indexPath.row == lastElement
               {
                    print("came to last row")
                    let lE = lastElement + 1
                    self.callAPIMeetingAll(url: meetingUrl, keyword: "no", constituency_id: GlobalVariables.shared.constituent_Id, offset: String(lE), rowcount: "50")
               }
           }
    }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let meeting_id = meetingIdArr[indexPath.row]
          self.performSegue(withIdentifier: "to_meetingallDetail", sender: meeting_id)
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
}
