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
    var id = String()
    var type = String()

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
        
        self.callAPIGreviancesAll(url: grevianceAllSearchUrl, keyword: keyword, paguthi: selectedconstitunecyId, offset: "0", rowcount: "50", grievance_type: statSelectdSeg)
    }
        
    func callAPIGreviancesAll (url : String, keyword: String, paguthi:String, offset:String, rowcount:String, grievance_type: String)
    {
        presenter.attachView(view: self)
        presenter.getGrieAll(url: url, keyword: keyword, paguthi: paguthi, offset: offset, rowcount: rowcount, grievance_type: grievance_type)
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
             
             self.placeArr.append(place)
             self.seekerTypeArr.append(seekerType)
             self.petitionNumberArr.append(petitionNumber)
             self.refNumberArr.append(refNumber)
             self.greivanceNameArr.append(greivanceName)
             self.subcatArr.append(subcat)
             self.descArr.append(desc)
             self.createdonArr.append(createdon)
             self.updatedOnArr.append(updatedOn)
             self.statusArr.append(status)
             self.greivanceIdArr.append(greivanceId)
             self.typeArr.append(type)
             self.userNameArr.append(username)
             self.dateArr.append(date)
             self.idArr.append(id)

         }
         self.greivancesCount.text =  String(format: "%@ %@", String (GlobalVariables.shared.consGreivanceCount),"Greivances")
         self.tableView.isHidden = false
         self.tableView.reloadData()
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
        
        if cell.status.text == "PROCESSING"{
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
//        let data = greivanceAllData[indexPath.row]
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
            vc.type = self.type
            vc.id = self.id
        }
    }
    

}


