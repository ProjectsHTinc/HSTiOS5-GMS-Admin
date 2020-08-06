//
//  ConstituentGreivances.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 20/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentGreivances: UIViewController {
    
    /* Constituent Greivances*/
    let Presenter = ConstituentgreivancesPresenter(constituentGreivancesService: ConstituentGreivancesService())
    var PresenterData = [ConstituentGreivancesData]()
    
    var selectedconstitunecyId = String()
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
    var filterdArr = [ConstituentGreivancesData]()
    var searchBar = UISearchController()

    @IBOutlet var greivanceCount: UILabel!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        self.tableView.backgroundColor = UIColor.white
        self.callAPI ()
        /*Lefft Navigation Bar*/
        self.addCustomizedBackBtn(title:"  Grievances")
        /*Right Navigation Bar*/
        self.addrightButton(bg_ImageName:"ConstituentSearch")
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
        print(selectedconstitunecyId)
        Presenter.attachView(view: self)
        Presenter.getConsGrie(constituent_id: selectedconstitunecyId)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_constituentGreDetail")
        {
            let vc = segue.destination as! ConstituentGreivancesDetail
            vc._place = _place
            vc._seekerType = _seekerType
            vc._petitionNumber = _petitionNumber
            vc._greivanceName = _greivanceName
            vc._subcat = _subcat
            vc._desc = _desc
            vc._createdon = _createdon
            vc._updatedOn = _updatedOn
            vc._status = _status
            vc.greivanceId = greivanceId
            vc._refNumber = _refNumber
            vc.type = self.type
        }
    }
    

}

extension ConstituentGreivances : ConstituentGreivancesView, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
         let searchText = searchController.searchBar.text?.lowercased()
         if searchText?.count != 0
         {
            filterdArr = PresenterData.filter({( model : ConstituentGreivancesData) -> Bool in
                return model.grievance_name.lowercased().contains(searchText!.lowercased())||model.sub_category_name.lowercased().contains(searchText!.lowercased())||model.grievance_type.lowercased().contains(searchText!.lowercased())||model.status.lowercased().contains(searchText!.lowercased())||model.petition_enquiry_no.lowercased().contains(searchText!.lowercased())||model.grievance_date.lowercased().contains(searchText!.lowercased())
             })
         }
         tableView.reloadData()
    }
    
    func startLoadingGri() {
        //
    }
    
    func finishLoadingGri() {
        //
    }
    
    func setConsGrie(ConsGri: [ConstituentGreivancesData]) {
        PresenterData = ConsGri
        filterdArr = PresenterData
        self.greivanceCount.text = String(GlobalVariables.shared.consGreivanceCount) + " " + "Greviances"
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
        self.greivanceCount.text = "0" + " Greviances"
        self.tableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if searchBar.isActive && searchBar.searchBar.text != "" {
             return filterdArr.count
         }
         else{
             return PresenterData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConstituentGreivancesCell
        if searchBar.isActive && searchBar.searchBar.text != ""
        {
            let data = filterdArr[indexPath.row]
            let type = data.grievance_type
            if (type == "P")
            {
                cell.pettionNumber.text = "Petition Number - " +  " " + data.petition_enquiry_no
            }
            else
            {
                cell.pettionNumber.text = "Enquiry Number - " +  " " + data.petition_enquiry_no
            }
    //      cell.greivanesType.text = data.grievance_type
            cell.greivanceName.text = data.grievance_name.capitalized
            cell.subCategoeryName.text = data.sub_category_name.capitalized
            cell.status.text = data.status.capitalized
            let formatedDate = self.formattedDateFromString(dateString: data.grievance_date, withFormat: "dd-MM-YYYY")
            cell.date.text = formatedDate
            
            if cell.status.text == "Processing"{
                cell.statusBgView.backgroundColor = UIColor(red: 253/255, green: 166/255, blue: 68/255, alpha: 1.0)
            }
            else{
                cell.statusBgView.backgroundColor = UIColor(red: 112/255, green: 173/255, blue: 71/255, alpha: 1.0)
            }
        }
        else
        {
            let data = PresenterData[indexPath.row]
            let type = data.grievance_type
            if (type == "P")
            {
                cell.pettionNumber.text = "Petition Number - " +  " " + data.petition_enquiry_no
            }
            else
            {
                cell.pettionNumber.text = "Enquiry Number - " +  " " + data.petition_enquiry_no
            }
    //      cell.greivanesType.text = data.grievance_type
            cell.greivanceName.text = data.grievance_name.capitalized
            cell.subCategoeryName.text = data.sub_category_name.capitalized
            cell.status.text = data.status.capitalized
            let formatedDate = self.formattedDateFromString(dateString: data.grievance_date, withFormat: "dd-MM-YYYY")
            cell.date.text = formatedDate
            
            if cell.status.text == "Processing"{
                cell.statusBgView.backgroundColor = UIColor(red: 253/255, green: 166/255, blue: 68/255, alpha: 1.0)
            }
            else{
                cell.statusBgView.backgroundColor = UIColor(red: 112/255, green: 173/255, blue: 71/255, alpha: 1.0)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 164
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = PresenterData[indexPath.row]
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
        self.greivanceId = data.id
        self.type = data.grievance_type
        self.performSegue(withIdentifier: "to_constituentGreDetail", sender: self)
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
