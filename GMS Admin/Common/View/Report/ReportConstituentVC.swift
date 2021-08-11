//
//  ReportConstituentVC.swift
//  GMS Admin
//
//  Created by HappysanziMac on 01/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class ReportConstituentVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, PaguthiView,OfficeView  {
    
    @IBOutlet var pageTitle: UILabel!
    @IBOutlet var reportImageView: UIImageView!
    @IBOutlet var paguthi: TextFieldWithImage!
    @IBOutlet var office: TextFieldWithImage!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    
    let presenter = PaguthiPresenter(areaService: AreaService())
    var paguthiData = [PaguthiData]()
    
    let presenterOffice = OfficePresenter(officeService: OfficeService())
    var officeData = [OfficeData]()

    let pickerView = UIPickerView()
    
    var paguthiName = [String]()
    var paguthiId = [String]()
    var selectedPaguthuID  = String()
    
    var officeName = [String]()
    var officeId = [String]()
    var selectedofficeID  = String()
    var infoArr = [String]()
    
    var selectedWhatsap = String()
    var selectedPhoneNum = String()
    var selectedemailId = String()
    var selectedDob = String()
    var selectedvoterId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        self.infoArr = ["WhatsApp Number","Phone Number","Email Id","Date Of Birth","Vote Id"]
     
        self.createPickerView()
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        callAPIOffice ()
        self.callAPIPaguthi()
    }
    
    func callAPIPaguthi ()
    {
        presenter.attachView(view: self)
        presenter.getPaguthi(constituency_id: GlobalVariables.shared.constituent_Id, dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    func callAPIOffice ()
    {
        presenterOffice.attachView(view: self)
        presenterOffice.getOffice(constituency_id: GlobalVariables.shared.constituent_Id, dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    func createPickerView() {
         pickerView.dataSource = self
         pickerView.delegate = self
         pickerView.backgroundColor = UIColor.white
         pickerView.setValue(UIColor.black, forKeyPath: "textColor")
       
         paguthi.inputView = pickerView
         office.inputView = pickerView

         let toolBar = UIToolbar()
         toolBar.sizeToFit()
         let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
         let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
         let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))

         toolBar.setItems([cancelButton,spaceButton,doneButton], animated: true)
         toolBar.isUserInteractionEnabled = true
         toolBar.backgroundColor = UIColor.white
         toolBar.tintColor = UIColor(red: 45/255.0, green: 148/255.0, blue: 235/255.0, alpha: 1.0)
         paguthi.inputAccessoryView = toolBar
         office.inputAccessoryView = toolBar
    }
    
    func dismissPickerView() {

    }
    
    @objc func action() {
         let row = self.pickerView.selectedRow(inComponent: 0)
         self.pickerView.selectRow(row, inComponent: 0, animated: false)
        
      if self.paguthi.isFirstResponder{
         self.paguthi.text = self.paguthiName[row]
         self.selectedPaguthuID = self.paguthiId[row]
      }
      else if self.office.isFirstResponder{
        self.office.text = self.officeName[row]
        self.selectedofficeID = self.officeId[row]
      }

          view.endEditing(true)
    }
    
    @objc func cancel() {
          view.endEditing(true)
    }
    
    @IBAction func whatsapAction(_ sender: Any) {
        
        image1.image = UIImage(named:"checkboxselected")
        selectedWhatsap = "yes"
    }
    
    @IBAction func mobileNo(_ sender: Any) {
        image2.image = UIImage(named:"checkboxselected")
        selectedPhoneNum = "yes"
    }
    
    @IBAction func emailAction(_ sender: Any) {
        image3.image = UIImage(named:"checkboxselected")
        selectedemailId = "yes"
    }
    
    @IBAction func dobAction(_ sender: Any) {
        image4.image = UIImage(named:"checkboxselected")
        selectedDob = "yes"
    }
    
    @IBAction func voterIdAction(_ sender: Any) {
        image5.image = UIImage(named:"checkboxselected")
        selectedvoterId = "yes"
    }
 
    @IBAction func search(_ sender: Any)
    {
        guard CheckValuesAreEmpty () else {
              return
        }
            self.performSegue(withIdentifier: "ConstituentList", sender: self)
//            self.performSegue(withIdentifier: "to_reportMeeting", sender: self)
//            self.performSegue(withIdentifier: "to_reportStaff", sender: self)
    }
    
    @IBAction func clear_Action(_ sender: Any) {
        
        self.paguthi.text = ""
        self.office.text = ""
        image1.image = UIImage(named:"checkbox")
        image2.image = UIImage(named:"checkbox")
        image3.image = UIImage(named:"checkbox")
        image4.image = UIImage(named:"checkbox")
        image5.image = UIImage(named:"checkbox")
    }
    
    
    func CheckValuesAreEmpty () -> Bool{

            guard Reachability.isConnectedToNetwork() == true else{
                  AlertController.shared.offlineAlert(targetVc: self, complition: {
                    //Custom action code
                 })
                 return false
        }
            
            guard self.paguthi.text?.count != 0  else {
                 AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Paguthi is Empty", complition: {
                      
                    })
                 return false
        }
        guard self.office.text?.count != 0  else {
             AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Office is Empty", complition: {
                  
                })
             return false
         }
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
      if self.office.isFirstResponder
        {
            return self.officeName.count
        }
        else
        {
            return self.paguthiName.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      
            if office.isFirstResponder
            {
                return self.officeName[row]
            }
            else {
                return self.paguthiName[row]

        }
    }
    
    func startLoading(){
        self.view.activityStartAnimating()
    }
    
    func finishLoading(){
         self.view.activityStopAnimating()
    }
    
    func setPaguthi(paguthi: [PaguthiData]) {
         paguthiData = paguthi
         self.paguthiName.removeAll()
         self.paguthiId.removeAll()
         for items in paguthiData
         {
            let paguthi = items.paguthi_name
            let id = items.id
            self.paguthiName.append(paguthi.capitalized)
            self.paguthiId.append(id)
//            pickerView.reloadAllComponents()
         }
         self.paguthiName.insert("ALL", at: 0)
         self.paguthiId.insert("ALL", at: 0)
    }
    
    func setoffice(office: [OfficeData]) {
        officeData = office
        self.officeName.removeAll()
        self.officeId.removeAll()
        for items in officeData
        {
           let office = items.office_name
            let id = items.id!
            self.officeName.append(office!.capitalized)
           self.officeId.append(id)
//            pickerView.reloadAllComponents()
        }
        self.officeName.insert("ALL", at: 0)
        self.officeId.insert("ALL", at: 0)
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "ConstituentList")
        {
            let vc = segue.destination as! ConstituentListVC
            vc.paguthi = self.selectedPaguthuID
            vc.office = self.selectedofficeID
            vc.whatsap = self.selectedWhatsap
            vc.emailId = self.selectedemailId
            vc.voterId = self.selectedvoterId
            vc.dob = self.selectedDob
            vc.phoneNum = self.selectedPhoneNum
            
//            vc.status = self.status.text!
//            vc.category = self.status.text!
//            vc.sub_category = self.status.text!
        }
    }
}
