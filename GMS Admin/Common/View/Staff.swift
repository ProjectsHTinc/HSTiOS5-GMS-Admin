//
//  Staff.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SideMenu

class Staff: UIViewController {
    
    /*Get Staff List*/
    let presenter = StaffPresenter(staffService: StaffService())
    var data = [staffData]()
    var filterdArr = [staffData]()
    var selectedSegmentIndexValue = Int()
    var fullNameArr = [String]()
    var idArr = [String]()
    var paguthiNameArr = [String]()
    var statusArr = [String]()
    var emailIdArr = [String]()
    var profilePicArr = [String]()
    var searchBar = UISearchController()
    var phoneNumberArr = [String]()

    @IBOutlet var staffCount: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.title = "Staff"
        //setupSideMenu()
        /*Set Side menu*/
        self.sideMenuButton()
        setUpStatSegmentControl ()
        /*Right Navigation Bar*/
        self.tableView.backgroundColor = UIColor.white
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        /*Right Navigation Bar*/
        self.addrightButton(bg_ImageName:"ConstituentSearch")
        tableView.tableFooterView = UIView()
        self.callAPIStaff ()
        
//        if segmentedControl.selectedSegmentIndex
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
    
    func makeSettings() -> SideMenuSettings {
        
        var settings = SideMenuSettings()
        settings.allowPushOfSameClassTwice = false
        settings.presentationStyle = .menuSlideIn
        settings.presentationStyle.backgroundColor = .black
        settings.presentationStyle.presentingEndAlpha = 0.5
        settings.statusBarEndAlpha = 0
        return settings
    }
    
    func setUpStatSegmentControl ()
    {
//        statSegContrl.backgroundColor = UIColor.white
        segmentedControl.tintColor = UIColor.white
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.black
            ], for: .normal)

        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 15) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.black
        ], for: .selected)
    }
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            self.selectedSegmentIndexValue  =  0
            
            if statusArr.contains("ACTIVE") {
//             let datas = filterdArr
     
            for datas in filterdArr {
                let fullName = datas.full_name
                let paguthiName = datas.paguthi_name
                let profilePic = datas.profile_pic
                let phoneNum = datas.phone_number
                let emailId = datas.email_id
                let status = datas.status
                
                self.fullNameArr.append(fullName)
                self.paguthiNameArr.append(paguthiName)
                self.emailIdArr.append(emailId)
                self.profilePicArr.append(profilePic)
                self.statusArr.append(status)
                self.phoneNumberArr.append(phoneNum)
            }
            self.tableView.isHidden = false
            self.tableView.reloadData()
            }
        }
        else {
            self.selectedSegmentIndexValue  =  1
            if statusArr.contains("INACTIVE") {
//             let datas = filterdArr
     
            for datas in filterdArr {
                let fullName = datas.full_name
                let paguthiName = datas.paguthi_name
                let profilePic = datas.profile_pic
                let phoneNum = datas.phone_number
                let emailId = datas.email_id
                let status = datas.status
                
                self.fullNameArr.append(fullName)
                self.paguthiNameArr.append(paguthiName)
                self.emailIdArr.append(emailId)
                self.profilePicArr.append(profilePic)
                self.statusArr.append(status)
                self.phoneNumberArr.append(phoneNum)
            }
            self.tableView.isHidden = false
            self.tableView.reloadData()
            }
        }
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
    
    func callAPIStaff ()
    {
        presenter.attachView(view: self)
        presenter.getStaff(constituency_id: GlobalVariables.shared.constituent_Id,dynamic_db:GlobalVariables.shared.dynamic_db)
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
        
        if (segue.identifier == "to_staffDetail"){
            let vc = segue.destination as! StaffDetail
            vc.staffId = sender as! String
        }
//        else if (segue.identifier == "to_sideMenu")
//        {
//            guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
//            sideMenuNavigationController.settings = makeSettings()
//        }
    }
}

extension Staff : StaffView, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
         let searchText = searchController.searchBar.text?.lowercased()
         if searchText?.count != 0
         {
            filterdArr = data.filter({( model : staffData) -> Bool in
             return model.full_name.lowercased().contains(searchText!.lowercased())||model.email_id.lowercased().contains(searchText!.lowercased())
                 || model.phone_number.lowercased().contains(searchText!.lowercased())||model.paguthi_name.lowercased().contains(searchText!.lowercased())
                 || model.status.lowercased().contains(searchText!.lowercased())
             })
         }
         tableView.reloadData()
    }
    
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setStaff(staff: [staffData]) {
        data = staff
        filterdArr = data
        self.staffCount.text = String(format: "%@ %@", String (GlobalVariables.shared.staffCount),"Staff")
        
        for datas in filterdArr {
            let fullName = datas.full_name
            let paguthiName = datas.paguthi_name
            let profilePic = datas.profile_pic
            let phoneNum = datas.phone_number
            let emailId = datas.email_id
            let status = datas.status
            
            self.fullNameArr.append(fullName)
            self.paguthiNameArr.append(paguthiName)
            self.emailIdArr.append(emailId)
            self.profilePicArr.append(profilePic)
            self.statusArr.append(status)
            self.phoneNumberArr.append(phoneNum)
        }
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
         self.tableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.isActive && searchBar.searchBar.text != "" {
            return filterdArr.count
        }
        else{
            return data.count
        }
    }
//    self.fullNameArr.append(fullName)
//    self.paguthiNameArr.append(paguthiName)
//    self.emailIdArr.append(emailId)
//    self.profilePicArr.append(profilePic)
//    self.statusArr.append(status)
//    self.phoneNumberArr.append(phoneNum)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StaffCell
        if searchBar.isActive && searchBar.searchBar.text != "" {
//            let staff = filterdArr[indexPath.row]
            cell.name.text = fullNameArr[indexPath.row]
            cell.mail.text = emailIdArr[indexPath.row]
            cell.location.text = paguthiNameArr[indexPath.row]
//            cell.status.text = statusArr[indexPath.row]
            cell.profPic.sd_setImage(with: URL(string: Globals.userImgUrl + profilePicArr[indexPath.row]), placeholderImage: UIImage(named: "placeholder.png"))

//            if cell.status.text == "Active"{
//                cell.status.textColor = UIColor(red: 106/255, green: 168/255, blue: 79/255, alpha: 1.0)
//                cell.statusView.backgroundColor = UIColor(red: 106/255, green: 168/255, blue: 79/255, alpha: 1.0)
//            }
//            else{
//                cell.status.textColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
//                cell.statusView.backgroundColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
//            }
        }
        else {
            cell.name.text = fullNameArr[indexPath.row]
            cell.mail.text = emailIdArr[indexPath.row]
            cell.location.text = paguthiNameArr[indexPath.row]
//            cell.status.text = statusArr[indexPath.row]
            cell.profPic.sd_setImage(with: URL(string: Globals.userImgUrl + profilePicArr[indexPath.row]), placeholderImage: UIImage(named: "placeholder.png"))

//            if cell.status.text == "Active"{
//                cell.status.textColor = UIColor(red: 106/255, green: 168/255, blue: 79/255, alpha: 1.0)
//                cell.statusView.backgroundColor = UIColor(red: 106/255, green: 168/255, blue: 79/255, alpha: 1.0)
//            }
//            else{
//                cell.status.textColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
//                cell.statusView.backgroundColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
            }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 142
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchBar.isActive && searchBar.searchBar.text != "" {
            let staff = filterdArr[indexPath.row]
            let staffId = staff.id
            self.searchBar.isActive = false
            self.performSegue(withIdentifier: "to_staffDetail", sender: staffId)
        }
        else{
            let staff = data[indexPath.row]
            let staffId = staff.id
            self.searchBar.isActive = false
            self.performSegue(withIdentifier: "to_staffDetail", sender: staffId)
        }
    }
}
