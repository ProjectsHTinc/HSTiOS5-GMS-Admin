//
//  InterAction.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class InterAction: UIViewController {
    
    let Presenter = InteractionPresenter(interactionService: InteractionService())
    var interactionData = [InteractionData]()

    var selectedconstitunecyId = String()

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
        self.callAPI()
    }
    
    func callAPI ()
    {
        Presenter.attachView(view: self)
        Presenter.getInteraction(constituent_id: selectedconstitunecyId)
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

extension InterAction: InteractionView , UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InteractionCell
        let data = interactionData[indexPath.row]
        cell.question.text = data.interaction_text
        let status = data.status
        if (status == "Yes"){
            cell.yesLabel.text = "Yes"
            cell.noLabel.text = "No"
            cell.yesLabel.backgroundColor = UIColor(red: 86 / 255.0, green: 223 / 255.0, blue: 149 / 255.0, alpha: 1.0)
            cell.noLabel.backgroundColor = UIColor(red: 196 / 255.0, green: 196 / 255.0, blue: 196 / 255.0, alpha: 1.0)
            cell.noLabel.textColor = UIColor.lightGray
        }
        else
        {
            cell.yesLabel.text = "Yes"
            cell.noLabel.text = "No"
            cell.yesLabel.backgroundColor = UIColor(red: 196 / 255.0, green: 196 / 255.0, blue: 196.0 / 255.0, alpha: 1.0)
            cell.noLabel.backgroundColor = UIColor(red: 255 / 255.0, green: 100 / 255.0, blue: 100 / 255.0, alpha: 1.0)
            cell.yesLabel.textColor = UIColor.lightGray

        }
        return cell
    }
    
    
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setInteraction(interaction: [InteractionData]) {
        interactionData = interaction
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
         self.tableView.isHidden = true
    }
    
    
}
