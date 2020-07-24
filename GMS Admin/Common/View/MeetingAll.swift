//
//  MeetingAll.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

let meetingUrl = "apiios/meetingRequestnew"

class MeetingAll: UIViewController {
    
    /*Get Meeting All List*/
    let presenter = MeetingAllPresenter(meetingAllService: MeetingAllService())
    var data = [MeetingAllData]()

    var searchBar = UISearchController()

    @IBOutlet var baseLine: UILabel!
    @IBOutlet var meetingCount: UILabel!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Meeting"
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
        self.callAPIMeetingAll(url: meetingUrl, keyword: "no", constituency_id: GlobalVariables.shared.constituent_Id, offset: "0", rowcount: "50")
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
        else
        {
            if (segue.identifier == "to_meetingallDetail"){
                let vc = segue.destination as! MeetingAllDetail
                vc.meetingId = sender as! String
            }
        }
    }
    

}

extension MeetingAll : MeetingAllDataView, UISearchBarDelegate ,  UITableViewDelegate, UITableViewDataSource
{
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setMeetingAll(meetingAll: [MeetingAllData]) {
        data = meetingAll
        self.meetingCount.text = String(GlobalVariables.shared.meetingAllCount) + " Meetings"
        self.tableView.isHidden = false
        self.meetingCount.isHidden = false
        self.baseLine.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
        self.tableView.isHidden = true
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
           return data.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MeetingAllCell
           let meetingData = data[indexPath.row]
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
                self.callAPIMeetingAll(url: "apiios/meetingRequestnew", keyword: "no", constituency_id: GlobalVariables.shared.constituent_Id, offset: String(totalRows), rowcount: "50")

               }
    
           }
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let meeting_id = data[indexPath.row]
          self.performSegue(withIdentifier: "to_meetingallDetail", sender: meeting_id.id)
       }
    
}
