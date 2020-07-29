//
//  GreivanceAllSearch.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

let grevianceAllSearchUrl = "apiios/listGrievancesearch"

class GreivanceAllSearch: UIViewController, GreivancesAllView,  UITableViewDelegate, UITableViewDataSource {

    /*Get Greivances List*/
    let presenter = GreivancesAllPresenter(greivancesAllService: GreivancesAllService())
    var greivanceAllData = [GreivancesAllData]()
    
    var selectedconstitunecyId = String()
    var statSelectdSeg = String()
    var keyword = String()
    
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addCustomizedBackBtn(title:"  Grievances Search")
        self.tableView.backgroundColor = UIColor.white
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        
        self.callAPIGreviancesAll(url: grevianceAllSearchUrl, keyword: keyword, paguthi: GlobalVariables.shared.selectedPaguthiId, offset: "0", rowcount: "50", grievance_type: statSelectdSeg)
    }
        
    func callAPIGreviancesAll (url : String, keyword: String, paguthi:String, offset:String, rowcount:String, grievance_type: String)
    {
        presenter.attachView(view: self)
        presenter.getGrieAll(url: url, keyword: keyword, paguthi: GlobalVariables.shared.selectedPaguthiId, offset: offset, rowcount: rowcount, grievance_type: grievance_type)
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
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
         self.tableView.isHidden = true
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
        let formatedDate = self.formattedDateFromString(dateString: data.grievance_date, withFormat: "dd-MM-YYYY")
        cell.date.text = formatedDate
        
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
            self.callAPIGreviancesAll(url: grevianceAllSearchUrl, keyword: keyword, paguthi: self.selectedconstitunecyId, offset: String(totalRows), rowcount: "50", grievance_type: statSelectdSeg)
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
        self.greivanceId = data.id
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
            if (segue.identifier == "to_GreivancesAllDetail"){
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


