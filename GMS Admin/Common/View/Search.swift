//
//  Search.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 07/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SDWebImage

class Search: UIViewController {
    
    var keyWord = String()
    @IBOutlet var tableView: UITableView!
    
    /*Get Search List*/
    let presenter = SearchPresenter(searchService: SearchService())
    var searchResult = [searchData]()
    var selectedconstitunecyId = String()

    var fullnameArr = [String]()
    var mobileNoArr = [String]()
    var serialNoArr = [String]()
    var profPicArr = [String]()
    var idArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.backgroundColor = UIColor.white
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        self.callAPISearch(offset: "0", rowCount: "50")
        self.addCustomizedBackBtn(title:"  Search Result")
        /*remove array Values*/
        self.fullnameArr.removeAll()
        self.mobileNoArr.removeAll()
        self.serialNoArr.removeAll()
        self.profPicArr.removeAll()
    }
    
    func callAPISearch (offset: String, rowCount: String)
    {
        presenter.attachView(view: self)
        presenter.getSearch(keyword: keyWord, offset: offset, rowcount: rowCount)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_constituentDetail"){
            let vc = segue.destination as! ConstituentDetail
            vc.selectedconstitunecyId = self.selectedconstitunecyId
        }
    }
    

}

extension Search : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return fullnameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchCell
//         let search = searchResult[indexPath.row]
         cell.username.text = fullnameArr[indexPath.row]
         cell.mobileNumber.text = mobileNoArr[indexPath.row]
         cell.serialNumber.text = String(format: "%@ %@", "Serila number - ",serialNoArr[indexPath.row])
         cell.userImage.sd_setImage(with: URL(string: Globals.imageUrl + profPicArr[indexPath.row]), placeholderImage: UIImage(named: "placeholder.png"))
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 118
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         if fullnameArr.count > 20
         {
            let lastElement = fullnameArr.count - 1
            if indexPath.row == lastElement
            {
               print("came to last row")
               self.callAPISearch(offset: String (lastElement), rowCount: "50")
            }
         }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let constituent = idArr[indexPath.row]
         self.selectedconstitunecyId = constituent
         self.performSegue(withIdentifier: "to_constituentDetail", sender: self)
    }
}

extension Search : SearchView
{
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setValues(search: [searchData]) {
        searchResult = search
        for items in searchResult{
            let name = items.full_name
            let mob = items.mobile_no
            let serialno = items.serial_no
            let profpic = items.profile_pic
            let id = items.id
            
            self.fullnameArr.append(name)
            self.mobileNoArr.append(mob)
            self.serialNoArr.append(serialno)
            self.profPicArr.append(profpic)
            self.idArr.append(id)
        }
        tableView?.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
         if fullnameArr.count == 0
         {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            })
            self.tableView.isHidden = true
         }
         else
         {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            })
            self.tableView.isHidden = false
         }
    }
    
}

