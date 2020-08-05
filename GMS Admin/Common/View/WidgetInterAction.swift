//
//  WidgetInterAction.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class WidgetInterAction: UIViewController {

    /*Get Search List*/
    let presenter = ConstituentinterActionPresenter(constituentInteractionService: ConstituentInteractionService())
    var CIData = [ConstituentinterActionData]()
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var paguthi_Id = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.titleLabel.text = "Constituent Interaction" 
        self.callAPICI()
        self.tableView.backgroundColor = UIColor.white
    }
    
    func callAPICI ()
    {
        presenter.attachView(view: self)
        presenter.getTotalGreviances(paguthi: paguthi_Id)
    }
    
    @IBAction func close(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
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

extension WidgetInterAction : UITableViewDelegate , UITableViewDataSource, ConstituentinterActionView
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CIData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WidgetInterActionCell
         let cIData = CIData[indexPath.row]
         cell.question.text = cIData.widgets_title
         cell.anscount.text = cIData.tot_values

         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func startLoadingCi() {
        //
    }
    
    func finishLoadingCI() {
        //
    }
    
    func setCI(consituentInteraction: [ConstituentinterActionData]) {
        
        CIData = consituentInteraction
        self.titleLabel.text =  "InterAction Count - " + GlobalVariables.shared.constituentInteractionCount
        self.tableView.isHidden = false
        self.tableView.reloadData()
         
    }
    
    func setEmptyCI(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
        self.tableView.isHidden = true
    }
    
    
}
