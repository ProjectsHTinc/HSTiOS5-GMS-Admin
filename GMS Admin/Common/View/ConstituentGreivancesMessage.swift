//
//  ConstituentGreivancesMessage.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 21/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentGreivancesMessage: UIViewController {
    
    /* Constituent Greivances*/
    let Presenter = ConstituentGreivancesMessagePresenter(constituentGreivancesMessageService: ConstituentGreivancesMessageService())
    var PresenterData = [ConstituentGreivancesMessageData]()

    var greivanceId = String()

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addCustomizedBackBtn(title:"  Message history")
        // Do any additional setup after loading the view.
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.white
        tableView.estimatedRowHeight = 157.0// the estimated row height ..the closer the better
        tableView.rowHeight = UITableView.automaticDimension
        self.callAPI ()
        
    }
    
    func callAPI ()
    {
        Presenter.attachView(view: self)
        Presenter.getConsGrieMessage(grievance_id: greivanceId)
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format

            return outputFormatter.string(from: date)
        }

        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ConstituentGreivancesMessage : ConstituentGreivancesMessageView, UITableViewDelegate, UITableViewDataSource{
    
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setConsGrieMessage(ConsGriMessage: [ConstituentGreivancesMessageData]) {
        PresenterData = ConsGriMessage
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
                AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
        self.tableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PresenterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConstituentGreivancesMessageCell
        let data = PresenterData[indexPath.row]
        cell.message.text = data.sms_text
        cell.sentBy.text = data.created_by
        let formatedDate = self.formattedDateFromString(dateString: data.created_at, withFormat: "dd-MMM-YYYY HH:mm:ss")
        cell.date.text = formatedDate
        return cell
    }
    
}
