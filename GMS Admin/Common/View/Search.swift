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
            _ = segue.destination as! ConstituentDetail
        }
    }
    

}

extension Search : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchCell
         let search = searchResult[indexPath.row]
         cell.username.text = search.full_name
         cell.mobileNumber.text = search.mobile_no
         cell.serialNumber.text = String(format: "%@ %@", "Serial Number - ",search.serial_no)
         cell.userImage.sd_setImage(with: URL(string: Globals.imageUrl + search.profile_pic), placeholderImage: UIImage(named: "PhUserImage.png"))
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 118
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         let totalRows = tableView.numberOfRows(inSection: indexPath.section)
         if indexPath.row == (totalRows - 1)
         {
            if totalRows >= 50{
                self.callAPISearch(offset: String (totalRows), rowCount: "50")
            }
            print("came to last row")
         }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let constituent = searchResult[indexPath.row]
         GlobalVariables.shared.constituent_Id = constituent.id
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
        tableView?.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
         tableView?.isHidden = true
    }
    
}

