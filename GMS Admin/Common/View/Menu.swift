//
//  SideMenu.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 07/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SDWebImage

@available(iOS 13.0, *)
class Menu: UITableViewController {
    
    var ConstituentisClicked = false
    var window: UIWindow?

    @IBOutlet var userLocation: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        /*Set BackgroundColor*/
        self.view.backgroundColor = UIColor.white
        /*Removeing NavigationBar Bottom Line*/
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        /*Update UI*/
        self.updateUI()
        if (GlobalVariables.shared.sideMenuDropdown == "true")
        {
            self.tableView.reloadData()
        }
    }
    
    func updateUI ()
    {
        self.userImage.sd_setImage(with: URL(string: GlobalVariables.shared.user_Image), placeholderImage: UIImage(named: "placeholder.png"))
        self.userName.text = GlobalVariables.shared.user_name
        self.userLocation.text = GlobalVariables.shared.selectedConstituencyName
        print(GlobalVariables.shared.user_Image,GlobalVariables.shared.selectedConstituencyName)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (indexPath.row == 0)
        {
             return 165
        }
        else if (indexPath.row == 2)
        {
            if (GlobalVariables.shared.sideMenuDropdown == "true")
            {
                return 119
            }
            else
            {
                 return 46
            }
        }
        else
        {
              return 46
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if (indexPath.row == 2)
        {
            if (ConstituentisClicked == false)
            {
                ConstituentisClicked = true
                GlobalVariables.shared.sideMenuDropdown = "true"
                tableView.reloadData()
            }
            else
            {
                ConstituentisClicked = false
                GlobalVariables.shared.sideMenuDropdown = "false"
                tableView.reloadData()
            }
        }
        else if (indexPath.row == 7)
        {
            self.clearAll()
        }
    }
    
    @available(iOS 13.0, *)
    func clearAll ()
    {
        GlobalVariables.shared.selectedConstituencyName = ""
        GlobalVariables.shared.CLIENTURL = ""
        GlobalVariables.shared.Devicetoken = ""
        GlobalVariables.shared.userCount = 0
        GlobalVariables.shared.user_id = ""
        GlobalVariables.shared.user_name = ""
        GlobalVariables.shared.user_location = ""
        GlobalVariables.shared.user_Image = ""
        GlobalVariables.shared.constituent_Id = ""
        GlobalVariables.shared.constituent_Count = 0
        GlobalVariables.shared.interActionCount = 0
        GlobalVariables.shared.selectedPaguthiId = ""
        GlobalVariables.shared.consGreivanceCount = 0
        GlobalVariables.shared.sideMenuDropdown = ""
        GlobalVariables.shared.meetingAllCount = 0
        GlobalVariables.shared.profGrivance = ""
        GlobalVariables.shared.staffCount = 0
        GlobalVariables.shared.result_count = 0
        GlobalVariables.shared.constituent_MemberCount = ""
        GlobalVariables.shared.totalMeetingsCount = ""
        GlobalVariables.shared.totalGrievancesCount = ""
        GlobalVariables.shared.constituentInteractionCount = ""
        UserDefaults.standard.clearUserData()
        self.performSegue(withIdentifier: "logOut", sender: self)


    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

