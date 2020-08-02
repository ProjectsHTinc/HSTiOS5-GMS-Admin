//
//  Staff.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Staff: UIViewController {
    
    /*Get Staff List*/
    let presenter = StaffPresenter(staffService: StaffService())
    var data = [staffData]()
    var filterdArr = [staffData]()

    var searchBar = UISearchController()

    @IBOutlet var staffCount: UILabel!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Staff"
        /*Set Side menu*/
        self.sideMenuButton()
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
        self.callAPIStaff ()
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
        presenter.getStaff(constituency_id: GlobalVariables.shared.constituent_Id)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StaffCell
        if searchBar.isActive && searchBar.searchBar.text != "" {
            let staff = filterdArr[indexPath.row]
            cell.name.text = staff.full_name
            cell.mail.text = staff.email_id
            cell.location.text = staff.paguthi_name
            cell.status.text = staff.status
            cell.profPic.sd_setImage(with: URL(string: Globals.userImgUrl + staff.profile_pic), placeholderImage: UIImage(named: "placeholder.png"))

            if cell.status.text == "ACTIVE"{
                cell.status.textColor = UIColor(red: 106/255, green: 168/255, blue: 79/255, alpha: 1.0)
                cell.statusView.backgroundColor = UIColor(red: 106/255, green: 168/255, blue: 79/255, alpha: 1.0)
            }
            else{
                cell.status.textColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
                cell.statusView.backgroundColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
            }
        }
        else{
            let staff = data[indexPath.row]
            cell.name.text = staff.full_name
            cell.mail.text = staff.email_id
            cell.location.text = staff.paguthi_name
            cell.status.text = staff.status
            cell.profPic.sd_setImage(with: URL(string: Globals.userImgUrl + staff.profile_pic), placeholderImage: UIImage(named: "placeholder.png"))

            if cell.status.text == "ACTIVE"{
                cell.status.textColor = UIColor(red: 106/255, green: 168/255, blue: 79/255, alpha: 1.0)
                cell.statusView.backgroundColor = UIColor(red: 106/255, green: 168/255, blue: 79/255, alpha: 1.0)
            }
            else{
                cell.status.textColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
                cell.statusView.backgroundColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchBar.isActive && searchBar.searchBar.text != "" {
            let staff = filterdArr[indexPath.row]
            let staffId = staff.id
            self.performSegue(withIdentifier: "to_staffDetail", sender: staffId)
        }
        else{
            let staff = data[indexPath.row]
            let staffId = staff.id
            self.performSegue(withIdentifier: "to_staffDetail", sender: staffId)
        }
    }
}
