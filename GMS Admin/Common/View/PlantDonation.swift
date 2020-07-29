//
//  PlantDonation.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class PlantDonation: UIViewController, PlantDonationView {

    let plantPresener = PlantDonationPresenter(plantDonationService: PlantDonationService())
    var plantData = [PlantDonationData]()
    
    var selectedconstitunecyId = String()
        
    @IBOutlet var plantName: UILabel!
    @IBOutlet var plantNumber: UILabel!
    @IBOutlet var recivedDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard checkInterConnection () else {
            return
        }
        
        self.addCustomizedBackBtn(title:"  Plant Donation")
        plantPresener.attachView(view: self)
        plantPresener.getPlantDonation(constituent_id: selectedconstitunecyId)
    }
    
    func checkInterConnection () -> Bool
    {
        guard Reachability.isConnectedToNetwork() == true else{
              self.view.isHidden = true
              self.view.backgroundColor = .white
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
              return false
        }
              return true
    }
    
    func startLoading() {
         
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        
        self.view.activityStopAnimating()
    }
    
    func setPlantDonation(plant: [PlantDonationData]) {
         plantData = plant
         self.plantName.text = plantData[0].name_of_plant
         self.plantNumber.text = plantData[0].no_of_plant
         let formated = self.formattedDateFromString(dateString: plantData[0].created_at, withFormat: "dd-MM-YYYY HH:mm:ss")
         self.recivedDate.text = formated
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
         
         self.plantName.text = "-"
         self.plantNumber.text = "-"
         self.recivedDate.text = "-"
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
