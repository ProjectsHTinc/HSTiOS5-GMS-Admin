//
//  GreivancesAll.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SideMenu

let grevianceAllUrl = "apiios/listGrievancenew"

class GreivancesAll: UIViewController {
    
    var searchBar = UISearchController()
    var segmentedControl = HMSegmentedControl()
    
    /*Get Paguthi List*/
    let Paguthipresenter = PaguthiPresenter(areaService: AreaService())
    var paguthiData = [PaguthiData]()
    
    /*Get Greivances List*/
    let presenter = GreivancesAllPresenter(greivancesAllService: GreivancesAllService())
    var greivanceAllData = [GreivancesAllData]()
    
    var constituencyName = [String]()
    var constituencyID = [String]()
    var selectedconstitunecyId = String()
    var statSelectdSeg = String()
    
    var _place = String()
    var _seekerType = String()
    var _petitionNumber = String()
    var _refNumber = String()
    var _greivanceName = String()
    var _subcat = String()
    var _desc = String()
    var _createdon = String()
    var _updatedOn = String()
    var _status = String()
    var greivanceId = String()
    var type = String()
    var id = String()

    var placeArr = [String]()
    var seekerTypeArr = [String]()
    var petitionNumberArr = [String]()
    var refNumberArr = [String]()
    var greivanceNameArr = [String]()
    var subcatArr = [String]()
    var descArr = [String]()
    var createdonArr = [String]()
    var updatedOnArr = [String]()
    var statusArr = [String]()
    var greivanceIdArr = [String]()
    var typeArr = [String]()
    var userNameArr = [String]()
    var dateArr = [String]()
    var idArr = [String]()

    @IBOutlet var tableView: UITableView!
    @IBOutlet var greivancesCount: UILabel!
    @IBOutlet var segmentView: UIView!
    @IBOutlet var statSegContrl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSideMenu()
        self.title = "Grievances"
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
        /*Remove Array Values*/
        self.placeArr.removeAll()
        self.seekerTypeArr.removeAll()
        self.petitionNumberArr.removeAll()
        self.refNumberArr.removeAll()
        self.greivanceNameArr.removeAll()
        self.subcatArr.removeAll()
        self.descArr.removeAll()
        self.createdonArr.removeAll()
        self.updatedOnArr.removeAll()
        self.statusArr.removeAll()
        self.greivanceIdArr.removeAll()
        self.typeArr.removeAll()
        self.userNameArr.removeAll()
        self.dateArr.removeAll()
        self.idArr.removeAll()
        //
        self.statSelectdSeg = "A"
        self.callAPIPaguthi ()
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
    
    func callAPIPaguthi ()
    {
        Paguthipresenter.attachView(view: self)
        Paguthipresenter.getPaguthi(constituency_id: GlobalVariables.shared.constituent_Id)
    }
    
    func callAPIGreviancesAll (url : String, keyword: String, paguthi:String, offset:String, rowcount:String, grievance_type: String)
    {
        presenter.attachView(view: self)
        presenter.getGrieAll(url: url, keyword: "no", paguthi: self.selectedconstitunecyId, offset: offset, rowcount: rowcount, grievance_type: grievance_type)
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
        self.setUpStatSegmentControl ()
    }
    
    func setUpStatSegmentControl ()
    {
        statSegContrl.backgroundColor = UIColor.white
        statSegContrl.tintColor = UIColor.white
        statSegContrl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
            NSAttributedString.Key.foregroundColor: UIColor(red: 45.0/255.0, green: 148.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            ], for: .normal)

        statSegContrl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ], for: .selected)
    }
    
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        self.placeArr.removeAll()
        self.seekerTypeArr.removeAll()
        self.petitionNumberArr.removeAll()
        self.refNumberArr.removeAll()
        self.greivanceNameArr.removeAll()
        self.subcatArr.removeAll()
        self.descArr.removeAll()
        self.createdonArr.removeAll()
        self.updatedOnArr.removeAll()
        self.statusArr.removeAll()
        self.greivanceIdArr.removeAll()
        self.typeArr.removeAll()
        self.userNameArr.removeAll()
        self.dateArr.removeAll()
        self.idArr.removeAll()
        self.reloadAndScrollToTop()
        print("Selected index \(segmentedControl.selectedSegmentIndex)")
        let selectedIndex = Int(segmentedControl.selectedSegmentIndex)
        let sel = self.constituencyID[selectedIndex]
        self.selectedconstitunecyId = String (sel)
        self.callAPIGreviancesAll(url: grevianceAllUrl, keyword: "no", paguthi: self.selectedconstitunecyId, offset: "0", rowcount: "50", grievance_type: statSelectdSeg)
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        self.placeArr.removeAll()
        self.seekerTypeArr.removeAll()
        self.petitionNumberArr.removeAll()
        self.refNumberArr.removeAll()
        self.greivanceNameArr.removeAll()
        self.subcatArr.removeAll()
        self.descArr.removeAll()
        self.createdonArr.removeAll()
        self.updatedOnArr.removeAll()
        self.statusArr.removeAll()
        self.greivanceIdArr.removeAll()
        self.typeArr.removeAll()
        self.userNameArr.removeAll()
        self.dateArr.removeAll()
        self.idArr.removeAll()
        self.reloadAndScrollToTop()
        
        if (statSegContrl.selectedSegmentIndex == 0)
        {
            self.statSelectdSeg = "A"
            self.callAPIGreviancesAll(url: grevianceAllUrl, keyword: "no", paguthi: self.selectedconstitunecyId, offset: "0", rowcount: "50", grievance_type: statSelectdSeg)
        }
        else if (statSegContrl.selectedSegmentIndex == 1){
            self.statSelectdSeg = "P"
            self.callAPIGreviancesAll(url: grevianceAllUrl, keyword: "no", paguthi: self.selectedconstitunecyId, offset: "0", rowcount: "50", grievance_type: statSelectdSeg)
        }
        else{
            self.statSelectdSeg = "E"
            self.callAPIGreviancesAll(url: grevianceAllUrl, keyword: "no", paguthi: self.selectedconstitunecyId, offset: "0", rowcount: "50", grievance_type: statSelectdSeg)
        }
    }
    
    func reloadAndScrollToTop() {
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.contentOffset = CGPoint(x: 0, y: -tableView.contentInset.top)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_greivanceAllSearch"){
            let vc = segue.destination as! GreivanceAllSearch
            vc.keyword = sender as! String
            vc.selectedconstitunecyId = self.selectedconstitunecyId
            vc.statSelectdSeg = self.statSelectdSeg
        }
        else if (segue.identifier == "to_GreivancesAllDetail"){
            let vc = segue.destination as! GreivancesAllDetail
            vc._place = _place
            vc._seekerType = _seekerType
            vc._petitionNumber = _petitionNumber
            vc._refNumber = _refNumber
            vc._greivanceName = _greivanceName
            vc._subcat = _subcat
            vc._desc = _desc
            vc._createdon = _createdon
            vc._updatedOn = _updatedOn
            vc._status = _status
            vc.greivanceId = greivanceId
            vc.type = self.type
            vc.id = self.id

        }
    }
}

extension GreivancesAll : PaguthiView , UISearchBarDelegate, GreivancesAllView , UITableViewDelegate, UITableViewDataSource
{    
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setPaguthi(paguthi: [PaguthiData]) {
        paguthiData = paguthi
        self.constituencyName.removeAll()
        self.constituencyID.removeAll()
        for item in paguthiData
        {
           let constituentName = item.paguthi_name
           let constituentId = item.id
           self.constituencyName.append(constituentName)
           self.constituencyID.append(constituentId)
        }
        self.constituencyName.insert("ALL", at: 0)
        self.constituencyID.insert("ALL", at: 0)
        self.setUpSegementControl()
        self.selectedconstitunecyId = String (self.constituencyID[0])
        print(self.selectedconstitunecyId)
        self.callAPIGreviancesAll(url: grevianceAllUrl, keyword: "no", paguthi: self.selectedconstitunecyId, offset: "0", rowcount: "50", grievance_type: self.statSelectdSeg)
    }
    
    func setEmpty(errorMessage: String) {
         if greivanceNameArr.count == 0
         {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            })
            self.greivancesCount.text =  String(format: "%@ %@", "0","Greivances")
            self.tableView.isHidden = true
         }
         else
         {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            })
            self.greivancesCount.text =  String(format: "%@ %@", String (GlobalVariables.shared.consGreivanceCount),"Greivances")
         }
    }
    
    func startLoadingGriAll() {
         self.view.activityStartAnimating()
    }
    
    func finishLoadingGriAll() {
         self.view.activityStopAnimating()
    }
    
    func setGrieAll(GriAll: [GreivancesAllData]) {
        greivanceAllData = GriAll
        for items in greivanceAllData{
            let place = items.paguthi_name
            let seekerType = items.seeker_info
            let petitionNumber = items.petition_enquiry_no
            let refNumber = items.reference_note
            let greivanceName = items.grievance_name
            let subcat = items.sub_category_name
            let desc = items.description
            let createdon = items.created_at
            let updatedOn = items.updated_at
            let status = items.status
            let greivanceId = items.constituent_id
            let type = items.grievance_type
            let username = items.full_name
            let date = items.grievance_date
            let id = items.constituent_id
            
            self.placeArr.append(place.capitalized)
            self.seekerTypeArr.append(seekerType.capitalized)
            self.petitionNumberArr.append(petitionNumber)
            self.refNumberArr.append(refNumber)
            self.greivanceNameArr.append(greivanceName.capitalized)
            self.subcatArr.append(subcat.capitalized)
            self.descArr.append(desc.capitalized)
            self.createdonArr.append(createdon)
            self.updatedOnArr.append(updatedOn)
            self.statusArr.append(status.capitalized)
            self.greivanceIdArr.append(greivanceId)
            self.typeArr.append(type)
            self.userNameArr.append(username.capitalized)
            self.dateArr.append(date)
            self.idArr.append(id)
        }
        self.greivancesCount.text =  String(format: "%@ %@", String (GlobalVariables.shared.consGreivanceCount),"Greivances")
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        
        self.performSegue(withIdentifier: "to_greivanceAllSearch", sender: searchBar.text!)
        self.searchBar.isActive = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return greivanceNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConstituentGreivancesCell
//        let data = greivanceAllData[indexPath.row]
        let type = typeArr[indexPath.row]
        if (type == "P"){
            cell.pettionNumber.text = "Petition Number - " +  " " + petitionNumberArr[indexPath.row]

        }
        else{
            cell.pettionNumber.text = "Enquiry Number - " +  " " + petitionNumberArr[indexPath.row]
        }
        cell.userName.text = userNameArr[indexPath.row]
        cell.greivanceName.text = greivanceNameArr[indexPath.row]
        cell.subCategoeryName.text = subcatArr[indexPath.row]
        cell.status.text = statusArr[indexPath.row]
        let formatedDate = self.formattedDateFromString(dateString: dateArr[indexPath.row], withFormat: "dd-MM-YYYY")
        cell.date.text = formatedDate
        
        if cell.status.text == "Processing"{
            cell.statusBgView.backgroundColor = UIColor(red: 253/255, green: 166/255, blue: 68/255, alpha: 1.0)
        }
        else{
            cell.statusBgView.backgroundColor = UIColor(red: 112/255, green: 173/255, blue: 71/255, alpha: 1.0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 181
    }
    
   func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       if greivanceNameArr.count > 20
       {
            let lastElement = greivanceNameArr.count - 1
            print (lastElement)
            if indexPath.row == lastElement
            {
                 print("came to last row")
                 let lE = lastElement + 1
                 self.callAPIGreviancesAll(url: grevianceAllUrl, keyword: "no", paguthi: self.selectedconstitunecyId, offset: String(lE), rowcount: "50", grievance_type: statSelectdSeg)
            }
       }
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      let data = greivanceAllData[indexPath.row]
        self._place = placeArr[indexPath.row]
        self._seekerType = seekerTypeArr[indexPath.row]
        self._petitionNumber = petitionNumberArr[indexPath.row]
        self._refNumber = refNumberArr[indexPath.row]
        self._greivanceName = greivanceNameArr[indexPath.row]
        self._subcat = subcatArr[indexPath.row]
        self._desc = descArr[indexPath.row]
        self._createdon = createdonArr[indexPath.row]
        self._updatedOn = updatedOnArr[indexPath.row]
        self._status = statusArr[indexPath.row]
        self.greivanceId = greivanceIdArr[indexPath.row]
        self.type = typeArr[indexPath.row]
        self.id = idArr[indexPath.row]
        self.performSegue(withIdentifier: "to_GreivancesAllDetail", sender: self)
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

