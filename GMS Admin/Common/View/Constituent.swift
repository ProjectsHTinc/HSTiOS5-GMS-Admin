//
//  Constituent.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 11/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SideMenu

class Constituent: UIViewController, PaguthiView {

    var searchBar = UISearchController()
    var segmentedControl = HMSegmentedControl()
    
    /*Get Paguthi List*/
    let Paguthipresenter = PaguthiPresenter(areaService: AreaService())
    var paguthiData = [PaguthiData]()
    
    var constituencyName = [String]()
    var constituencyID = [String]()
    var selectedconstitunecyId = String()

    /*Get Search List*/
    let presenter = ListConstituentPresenter(listConstituentservice: ListConstituentservice())
    var listConstituent = [ListConstituencyData]()

    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentView: UIView!
    @IBOutlet var constituentCount: UILabel!
    @IBOutlet var bottomLine: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Constituent"
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
        self.constituentCount.isHidden = true
        self.bottomLine.isHidden = true
        self.callAPIPaguthi ()
    }
    
    func callAPIPaguthi ()
    {
        Paguthipresenter.attachView(view: self)
        Paguthipresenter.getPaguthi(constituency_id: GlobalVariables.shared.constituent_Id)
    }
    
    func callAPISearch (constituency_id:String, offset: String, rowcount:String)
    {
        presenter.attachView(view: self)
        presenter.getconstituencyList(paguthi: constituency_id, offset: offset, rowcount: rowcount)
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

        // Make this class the delegate and present the search
        self.searchBar.searchBar.delegate = self
        present(searchBar, animated: true, completion: nil)
    }
    
    func setUpSegementControl ()
    {
        segmentedControl = HMSegmentedControl(sectionTitles: self.constituencyName)
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.frame = CGRect(x: 0, y: 0, width: self.segmentView.frame.width, height: 50)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        segmentView.addSubview(segmentedControl)
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 45/155, green: 148/255, blue: 235/255, alpha: 1.0)]
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.bottom
        segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.fixed
        segmentedControl.selectionIndicatorHeight = 2.0
        segmentedControl.selectionIndicatorColor = UIColor(red: 45/155, green: 148/255, blue: 235/255, alpha: 1.0)
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 15.0)!]
    }
    
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        print("Selected index \(segmentedControl.selectedSegmentIndex)")
        let selectedIndex = Int(segmentedControl.selectedSegmentIndex)
        let sel = self.constituencyID[selectedIndex]
        self.selectedconstitunecyId = String (sel)
        self.callAPISearch(constituency_id: self.selectedconstitunecyId,offset: "0",rowcount: "50")
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_search")
        {
            let vc = segue.destination as! Search
            vc.keyWord = sender as! String
        }
        else if (segue.identifier == "to_constituentDetail"){
            _ = segue.destination as! ConstituentDetail
        }
    }
    

}

extension Constituent: UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource , ListConstituencyView
{

    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
             
        self.performSegue(withIdentifier: "to_search", sender: searchBar.text)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listConstituent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchCell
        let constituent = listConstituent[indexPath.row]
        cell.username.text = constituent.full_name
        cell.mobileNumber.text = constituent.mobile_no
        cell.serialNumber.text = String(format: "%@ %@", "Serila number - ",constituent.serial_no)
        cell.userImage.sd_setImage(with: URL(string: Globals.imageUrl + constituent.profile_pic), placeholderImage: UIImage(named: "PhUserImage.png"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        if indexPath.row == (totalRows - 1)
        {
            if totalRows >= 50
            {
                print("came to last row")
                self.callAPISearch(constituency_id: self.selectedconstitunecyId,offset: String(totalRows),rowcount: "50")
            }
 
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let constituent = listConstituent[indexPath.row]
        GlobalVariables.shared.constituent_Id = constituent.id
        self.performSegue(withIdentifier: "to_constituentDetail", sender: self)
    }
    
    func startLoading() {
        //self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        //self.view.activityStopAnimating()
    }
    
    func setEmptyListConstituency(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         //self.dismiss(animated: false, completion: nil)
        })
         //tableView?.isHidden = true
    }
    
//    func setConstituency(constituencyname: [constituencyData]) {
//         constituencyNameList = constituencyname
//         for item in constituencyNameList
//         {
//             let constituentName = item.constituency_name
//             let constituentId = item.constituency_id
//             self.constituencyName.append(constituentName)
//             self.constituencyID.append(constituentId)
//         }
//
//         self.setUpSegementControl()
//         self.selectedconstitunecyId = String (self.constituencyID[0])
//         print(self.selectedconstitunecyId)
//         self.callAPISearch(constituency_id: self.selectedconstitunecyId, offset:"0", rowcount: "50")
//
//    }
    
    func setPaguthi(paguthi: [PaguthiData]) {
        
         paguthiData = paguthi
         for item in paguthiData
         {
            let constituentName = item.paguthi_name
            let constituentId = item.constituency_id
            self.constituencyName.append(constituentName)
            self.constituencyID.append(constituentId)
         }

         self.setUpSegementControl()
         self.selectedconstitunecyId = String (self.constituencyID[0])
         print(self.selectedconstitunecyId)
         self.callAPISearch(constituency_id: self.selectedconstitunecyId, offset:"0", rowcount: "50")
        
    }
    
    func setEmpty(errorMessage: String) {
        //
    }
    
    func setConstituent(constituentname: [ListConstituencyData]) {
        listConstituent = constituentname
        self.constituentCount.text =   String(format: "%@ %@", String (GlobalVariables.shared.constituent_Count),"Constituent")
        self.constituentCount.isHidden = false
        self.bottomLine.isHidden = false
        tableView?.isHidden = false
        self.tableView.reloadData()
    }
}

