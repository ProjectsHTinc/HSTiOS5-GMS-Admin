//
//  Meeting.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SideMenu

class Meeting: UIViewController {
    
    let meetingPresener = MeetingPresenter(meetingService: MeetingService())
    var meetingeData = [MeetingData]()
    
    var selectedconstitunecyId = String()
    var meeting_Title = String()
    var meeting_Discrption = String()
    var meeting_Date = String()
    var meeting_Status = String()
    var From = String()
    
    var filterdArr = [MeetingData]()
    var searchBar = UISearchController()

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Check Internet Connection*/
        //setupSideMenu()
        guard checkInterConnection () else {
            return
        }
        
        self.view.isHidden = false
        if From == "Cd"{
            self.addCustomizedBackBtn(title:"  Meeting")
        }
        else{
            /*Set Side menu*/
            self.sideMenuButton()
            self.title = "Meeting"
        }
        //self.addCustomizedBackBtn(title:"  Meeting")
        /*Right Navigation Bar*/
        self.addrightButton(bg_ImageName:"ConstituentSearch")
        self.searchBar.delegate = self
        self.tableView?.backgroundColor = .white
        /*Call API*/
        self.callAPI(offset: "0", rowcount: "50")
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
    
    @objc public override func sideMenuButtonClick()
    {
        self.performSegue(withIdentifier: "to_sideMenu", sender: self)
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
    
    func checkInterConnection () -> Bool
    {
        guard Reachability.isConnectedToNetwork() == true else{
              self.view.isHidden = true
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
              return false
        }
              return true
    }

    func callAPI(offset:String,rowcount:String)
    {
        meetingPresener.attachView(view: self)
        meetingPresener.getMeeting(constituency_id: selectedconstitunecyId, offset: offset, rowcount: rowcount)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "to_MeetingDetails")
        {
            let vc = segue.destination as! MeetingDetail
            vc.meeting_Title = meeting_Title
            vc.meeting_Discrption = meeting_Discrption
            vc.meeting_Date = meeting_Date
            vc.meeting_Status = meeting_Status
        }
//        else if (segue.identifier == "to_sideMenu")
//        {
//            guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
//            sideMenuNavigationController.settings = makeSettings()
//        }
    }

}

extension Meeting: UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
         let searchText = searchController.searchBar.text?.lowercased()
         if searchText?.count != 0
         {
            filterdArr = meetingeData.filter({( model : MeetingData) -> Bool in
                return model.meeting_title.lowercased().contains(searchText!.lowercased())||model.meeting_date.lowercased().contains(searchText!.lowercased())||model.meeting_status.lowercased().contains(searchText!.lowercased())
             })
         }
         tableView.reloadData()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.isActive && searchBar.searchBar.text != "" {
            return filterdArr.count
        }
        else{
            return meetingeData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MeetingCell
        if searchBar.isActive && searchBar.searchBar.text != ""
        {
            let data = filterdArr[indexPath.row]
            cell.meetingTitle.text = data.meeting_title
            let formatedDate = self.formattedDateFromString(dateString: data.meeting_date, withFormat: "dd-MM-YYYY")
            cell.meetingdate.text = formatedDate
            cell.meetingStatus.text = data.meeting_status
            
            if cell.meetingStatus.text == "REQUESTED" || cell.meetingStatus.text == "PROCESSING"
            {
                cell.meetingTitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                cell.meetingdate.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                cell.titleImageGroup.image = UIImage(named: "meetingGroupIcon")
                cell.calenderImage.image = UIImage(named: "meetingDate")
                cell.sidedBg.backgroundColor = UIColor(red: 253.0/255, green: 166.0/255, blue: 68.0/255, alpha: 1.0)
            }
            else
            {
                cell.meetingTitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
                cell.meetingdate.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
                cell.titleImageGroup.image = UIImage(named: "meetingCompleted")
                cell.calenderImage.image = UIImage(named: "meetingCompletedDate")
                cell.sidedBg.backgroundColor =  UIColor(red: 112.0/255, green: 173.0/255, blue: 71.0/255, alpha: 0.6)
            }
        }
        else
        {
            let data = meetingeData[indexPath.row]
            cell.meetingTitle.text = data.meeting_title.capitalized
            let formatedDate = self.formattedDateFromString(dateString: data.meeting_date, withFormat: "dd-MM-YYYY")
            cell.meetingdate.text = formatedDate
            cell.meetingStatus.text = data.meeting_status.capitalized
            
            if cell.meetingStatus.text == "Requested" || cell.meetingStatus.text == "Processing"
            {
                cell.meetingTitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                cell.meetingdate.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                cell.titleImageGroup.image = UIImage(named: "meetingGroupIcon")
                cell.calenderImage.image = UIImage(named: "meetingDate")
                cell.sidedBg.backgroundColor = UIColor(red: 253.0/255, green: 166.0/255, blue: 68.0/255, alpha: 1.0)
            }
            else
            {
                cell.meetingTitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
                cell.meetingdate.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
                cell.titleImageGroup.image = UIImage(named: "meetingCompleted")
                cell.calenderImage.image = UIImage(named: "meetingCompletedDate")
                cell.sidedBg.backgroundColor =  UIColor(red: 112.0/255, green: 173.0/255, blue: 71.0/255, alpha: 0.6)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if meetingeData.count > 20
        {
            let lastElement = meetingeData.count - 1
            if indexPath.row == lastElement
            {
                print("came to last row")
                self.callAPI(offset: String(lastElement), rowcount: "50")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchBar.isActive && searchBar.searchBar.text != ""
        {
            self.searchBar.isActive = false
            let data = filterdArr[indexPath.row]
            self.meeting_Title = data.meeting_title.capitalized
            self.meeting_Discrption = data.meeting_detail
            self.meeting_Date = data.meeting_date
            self.meeting_Status = data.meeting_status.capitalized
        }
        else
        {
            let data = meetingeData[indexPath.row]
            self.meeting_Title = data.meeting_title.capitalized
            self.meeting_Discrption = data.meeting_detail
            self.meeting_Date = data.meeting_date
            self.meeting_Status = data.meeting_status.capitalized
        }

        self.performSegue(withIdentifier: "to_MeetingDetails", sender: self)
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

extension Meeting: MeetingView
{
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setMeeting(meeting: [MeetingData]) {
         meetingeData = meeting
         filterdArr = meetingeData
         self.tableView?.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
         
        if meetingeData.count == 0
        {
             AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
             })
             self.tableView.isHidden = true
        }
        else{
             AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
             })
             self.tableView.isHidden = false
        }

    }
    
}
