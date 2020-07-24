//
//  GreivancesAll.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

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
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var greivancesCount: UILabel!
    @IBOutlet var segmentView: UIView!
    @IBOutlet var statSegContrl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        self.statSelectdSeg = "A"
        self.callAPIPaguthi ()
    }
    
    func callAPIPaguthi ()
    {
        Paguthipresenter.attachView(view: self)
        Paguthipresenter.getPaguthi(constituency_id: GlobalVariables.shared.constituent_Id)
    }
    
    func callAPIGreviancesAll (url : String, keyword: String, paguthi:String, offset:String, rowcount:String, grievance_type: String)
    {
        presenter.attachView(view: self)
        presenter.getGrieAll(url: url, keyword: "no", paguthi: GlobalVariables.shared.selectedPaguthiId, offset: offset, rowcount: rowcount, grievance_type: grievance_type)
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
        GlobalVariables.shared.selectedPaguthiId = String (sel)
        self.callAPIGreviancesAll(url: grevianceAllUrl, keyword: "no", paguthi: GlobalVariables.shared.selectedPaguthiId, offset: "0", rowcount: "50", grievance_type: statSelectdSeg)
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        if (statSegContrl.selectedSegmentIndex == 0)
        {
            self.statSelectdSeg = "A"
            self.callAPIGreviancesAll(url: grevianceAllUrl, keyword: "no", paguthi: GlobalVariables.shared.selectedPaguthiId, offset: "0", rowcount: "50", grievance_type: statSelectdSeg)
        }
        else if (statSegContrl.selectedSegmentIndex == 1){
            self.statSelectdSeg = "P"
            self.callAPIGreviancesAll(url: grevianceAllUrl, keyword: "no", paguthi: GlobalVariables.shared.selectedPaguthiId, offset: "0", rowcount: "50", grievance_type: statSelectdSeg)
        }
        else{
            self.statSelectdSeg = "E"
            self.callAPIGreviancesAll(url: grevianceAllUrl, keyword: "no", paguthi: GlobalVariables.shared.selectedPaguthiId, offset: "0", rowcount: "50", grievance_type: statSelectdSeg)
        }
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
        self.callAPIGreviancesAll(url: grevianceAllUrl, keyword: "no", paguthi: GlobalVariables.shared.selectedPaguthiId, offset: "0", rowcount: "50", grievance_type: "A")
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
         self.tableView.isHidden = true
    }
    
    func startLoadingGriAll() {
        //
    }
    
    func finishLoadingGriAll() {
        //
    }
    
    func setGrieAll(GriAll: [GreivancesAllData]) {
        greivanceAllData = GriAll
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
        return greivanceAllData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConstituentGreivancesCell
        let data = greivanceAllData[indexPath.row]
        cell.pettionNumber.text = "Petition Number - " +  " " + data.petition_enquiry_no
//        cell.greivanesType.text = data.grievance_type
        cell.greivanceName.text = data.grievance_name
        cell.subCategoeryName.text = data.sub_category_name
        cell.status.text = data.status
        cell.date.text = data.grievance_date
        
        if cell.status.text == "PROCESSING"{
            cell.statusBgView.backgroundColor = UIColor(red: 253/255, green: 166/255, blue: 68/255, alpha: 1.0)
        }
        else{
            cell.statusBgView.backgroundColor = UIColor(red: 112/255, green: 173/255, blue: 71/255, alpha: 1.0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 164
    }
    
   func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       let totalRows = tableView.numberOfRows(inSection: indexPath.section)
       if indexPath.row == (totalRows - 1)
       {
           if totalRows >= 50
           {
             print("came to last row")
            self.callAPIGreviancesAll(url: grevianceAllUrl, keyword: "no", paguthi: GlobalVariables.shared.selectedPaguthiId, offset: String(totalRows), rowcount: "50", grievance_type: statSelectdSeg)
           }

       }
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = greivanceAllData[indexPath.row]
        self._place = data.paguthi_name
        self._seekerType = data.seeker_info
        self._petitionNumber = data.petition_enquiry_no
        self._refNumber = data.reference_note
        self._greivanceName = data.grievance_name
        self._subcat = data.sub_category_name
        self._desc = data.description
        self._createdon = data.created_at
        self._updatedOn = data.updated_at
        self._status = data.status
        self.greivanceId = data.constituent_id
        self.performSegue(withIdentifier: "to_GreivancesAllDetail", sender: self)
    }
}
