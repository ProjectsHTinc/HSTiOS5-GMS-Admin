//
//  ReportStatus.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ReportStatus: UIViewController {
    
    /*Get Paguthi List*/
    let presenter = PaguthiPresenter(areaService: AreaService())
    var paguthiData = [PaguthiData]()
    
    /*Get Categoery List*/
    let presenterCategoery = CategoeryPresenter(categoeryService: CategoeryService())
    var categoeryData = [CategoeryData]()
    
    /*Get Sub Categoery List*/
    let presenterSubCategoery = SubCategoeryPresenter(subCategoeryService: SubCategoeryService())
    var subCategoeryData = [SubCategoeryData]()
    
    var paguthiName = [String]()
    var paguthiId = [String]()
    var selectedPaguthuID  = String()
    
    var categoeryName = [String]()
    var catgoeryId = [String]()
    
    var subCategoeryName = [String]()
    var subCatgoeryId = [String]()
    
    var from = String()
    var statusArr = [String]()
    var subCat = [String]()
    var Cate = [String]()
    
    let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
    
    var selectedFromDate = Date()
    var selectedToDate = Date()
    var textfieldName = String()
    
    var fromDateFormatted = String()
    var toDateFormatted = String()

    @IBOutlet var pageTitle: UILabel!
    @IBOutlet var statusHeight: NSLayoutConstraint!
    @IBOutlet var paguthiHeight: NSLayoutConstraint!
    @IBOutlet var reportImageView: UIImageView!
    @IBOutlet var fromDate: TextFieldWithImage!
    @IBOutlet var toDate: TextFieldWithImage!
    @IBOutlet var status: TextFieldWithImage!
    @IBOutlet var paguthi: TextFieldWithImage!
    @IBOutlet var downArrowStatus: UIImageView!
    @IBOutlet var downArrowPaguthi: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*Tap anywhere to hide keypad*/
        self.hideKeyboardWhenTappedAround()
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        if (from == "status"){
            self.pageTitle.text = "Status"
            self.addCustomizedBackBtn(title:"  Status Report")
            self.reportImageView.image = UIImage(named: "ReportStatus")
            self.statusArr = ["ALL","REQUEST","COMPLETED"]
            self.textfieldName = "Status"
        }
        else if (from == "categoery"){
            self.pageTitle.text = "Category"
            self.addCustomizedBackBtn(title:"  Category Report")
            self.reportImageView.image = UIImage(named: "ReportCategoery")
            status.attributedPlaceholder =
            NSAttributedString(string: "Select Categoery", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 188 / 255, green: 188 / 255, blue: 188 / 255, alpha: 1.0)])
            //self.Cate = ["ALL","1"]
            self.downArrowPaguthi.isHidden = true
            self.paguthiHeight.constant = 0
            self.textfieldName = "Categoery"

        }
        else if (from == "subCate"){
            self.pageTitle.text = "Sub category"
            self.addCustomizedBackBtn(title:"  Sub category Report")
            self.reportImageView.image = UIImage(named:"ReportSubcat")
            status.attributedPlaceholder =
            NSAttributedString(string: "  Select Sub Categoery", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 188 / 255, green: 188 / 255, blue: 188 / 255, alpha: 1.0)])
            //self.subCat = ["ALL","1"]
            self.downArrowPaguthi.isHidden = true
            self.paguthiHeight.constant = 0
            self.textfieldName = "Sub Categoery"

        }
        else if (from == "location"){
            self.pageTitle.text = "Location"
            self.addCustomizedBackBtn(title:"  Location Report")
            self.reportImageView.image = UIImage(named: "ReportLocation")
            status.attributedPlaceholder =
            NSAttributedString(string: "Select Location", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 188 / 255, green: 188 / 255, blue: 188 / 255, alpha: 1.0)])
            self.downArrowPaguthi.isHidden = true
            self.paguthiHeight.constant = 0
            self.textfieldName = "Location"

        }
        else if (from == "meeting"){
            self.pageTitle.text = "Meeting"
            self.addCustomizedBackBtn(title:"  Meeting Report")
            self.reportImageView.image = UIImage(named: "ReportMeeting")
            self.downArrowStatus.isHidden = true
            self.downArrowPaguthi.isHidden = true
            self.statusHeight.constant = 0
            self.paguthiHeight.constant = 0
            self.textfieldName = "Meeting"

        }
        else if (from == "staff"){
            self.pageTitle.text = "Staff"
            self.addCustomizedBackBtn(title:"  Staff Report")
            self.reportImageView.image = UIImage(named: "ReportStaff")
            self.downArrowStatus.isHidden = true
            self.downArrowPaguthi.isHidden = true
            self.statusHeight.constant = 0
            self.paguthiHeight.constant = 0
            self.textfieldName = "Staff"

        }
        /*SetUp DatePicker*/
        self.showDatePicker()
        /*SetUp PickerView*/
        self.createPickerView()
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        
        if (from == "status") || (from == "location"){
            self.callAPIPaguthi()
        }
        else if (from == "categoery"){
            self.callAPICategoery()
        }
        else if (from == "subCate"){
            self.callAPISubCategoery()
        }
    }
    
    func callAPIPaguthi ()
    {
        presenter.attachView(view: self)
        presenter.getPaguthi(constituency_id: GlobalVariables.shared.constituent_Id)
    }
    
    func callAPICategoery ()
    {
        presenterCategoery.attachView(view: self)
        presenterCategoery.getCategoery(user_id: GlobalVariables.shared.user_id)
    }
    
    func callAPISubCategoery ()
    {
        presenterSubCategoery.attachView(view: self)
        presenterSubCategoery.getSubCate(user_id: GlobalVariables.shared.user_id)
    }
    
    func showDatePicker(){
       //Formate Date
       datePicker.datePickerMode = .date
       datePicker.backgroundColor = UIColor.white
       datePicker.setValue(UIColor.black, forKeyPath: "textColor")

       //ToolBar
       let toolbar = UIToolbar();
       toolbar.sizeToFit()
       toolbar.backgroundColor = UIColor.white
       toolbar.tintColor = UIColor(red: 45/255.0, green: 148/255.0, blue: 235/255.0, alpha: 1.0)
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
       let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
       let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
       toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

       fromDate.inputAccessoryView = toolbar
       fromDate.inputView = datePicker
        
       toDate.inputAccessoryView = toolbar
       toDate.inputView = datePicker

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
    
     @objc func donedatePicker(){
        if fromDate.isFirstResponder
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            fromDateFormatted = formatter.string(from: datePicker.date)
            selectedFromDate = datePicker.date
            let formatted = self.formattedDateFromString(dateString: fromDateFormatted, withFormat: "dd-MM-YYYY")
            fromDate.text = formatted
            self.view.endEditing(true)
        }
        else
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            toDateFormatted = formatter.string(from: datePicker.date)
            selectedToDate = datePicker.date
            let formatted = self.formattedDateFromString(dateString: toDateFormatted, withFormat: "dd-MM-YYYY")
            toDate.text = formatted
            self.view.endEditing(true)
        }

    }
        
    @objc func cancelDatePicker(){
       self.view.endEditing(true)
     }
    
    func createPickerView() {
         pickerView.dataSource = self
         pickerView.delegate = self
         pickerView.backgroundColor = UIColor.white
         pickerView.setValue(UIColor.black, forKeyPath: "textColor")
         status.inputView = pickerView
         paguthi.inputView = pickerView
         let toolBar = UIToolbar()
         toolBar.sizeToFit()
         let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
         let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
         let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))

         toolBar.setItems([cancelButton,spaceButton,doneButton], animated: true)
         toolBar.isUserInteractionEnabled = true
         toolBar.backgroundColor = UIColor.white
         toolBar.tintColor = UIColor(red: 45/255.0, green: 148/255.0, blue: 235/255.0, alpha: 1.0)
         status.inputAccessoryView = toolBar
         paguthi.inputAccessoryView = toolBar
    }
    
    func dismissPickerView() {

    }
    
    @objc func action() {
         let row = self.pickerView.selectedRow(inComponent: 0)
         self.pickerView.selectRow(row, inComponent: 0, animated: false)
         if self.status.isFirstResponder{
         if (from == "status"){
             status.text = self.statusArr[row] // selected item
         }
         else if (from == "categoery") {
             status.text = self.categoeryName[row] // selected item
             self.selectedPaguthuID = self.catgoeryId[row]
             print(self.selectedPaguthuID)
         }
         else if (from == "subCate")
         {
             status.text = self.subCategoeryName[row] // selected item
             self.selectedPaguthuID = self.subCatgoeryId[row]
             print(self.selectedPaguthuID)
         }
         else
         {
             self.status.text = self.paguthiName[row]
             self.selectedPaguthuID = self.paguthiId[row]
         }
      }
      else if self.paguthi.isFirstResponder{
         self.paguthi.text = self.paguthiName[row]
         self.selectedPaguthuID = self.paguthiId[row]
      }

          view.endEditing(true)
    }
    
    @objc func cancel() {
          view.endEditing(true)
    }
    
    @IBAction func search(_ sender: Any)
    {
        guard CheckValuesAreEmpty () else {
              return
        }
        if (from == "status") || (from == "categoery") || (from == "subCate") || (from == "location")
        {
            self.performSegue(withIdentifier: "to_reportList", sender: self.from)
        }
        else if (from == "meeting")
        {
            self.performSegue(withIdentifier: "to_reportMeeting", sender: self)
        }
        else if from == "staff"
        {
            self.performSegue(withIdentifier: "to_reportStaff", sender: self)
        }
    }
    
    func CheckValuesAreEmpty () -> Bool{
        
        let greater = selectedFromDate.timeIntervalSince1970 < selectedToDate.timeIntervalSince1970
        if (from == "status")
        {
            guard Reachability.isConnectedToNetwork() == true else{
                  AlertController.shared.offlineAlert(targetVc: self, complition: {
                    //Custom action code
                 })
                 return false
            }
            
            guard self.fromDate.text?.count != 0  else {
                AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "From Date is Empty", complition: {
                    
                  })
                 return false
             }
            
            guard self.toDate.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To Date is Empty", complition: {
                      
                    })
                 return false
             }
            
            guard greater == true  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To date cannot be before start date", complition: {
                      
                    })
                 return false
             }
            
            guard self.status.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: textfieldName + " " + "is Empty", complition: {
                      
                    })
                 return false
             }
            
            guard self.paguthi.text?.count != 0  else {
                 AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Paguthi is Empty", complition: {
                      
                    })
                 return false
             }
        }
        else if (from == "categoery")
        {
            guard Reachability.isConnectedToNetwork() == true else{
                  AlertController.shared.offlineAlert(targetVc: self, complition: {
                    //Custom action code
                 })
                 return false
            }
            
            guard self.fromDate.text?.count != 0  else {
                AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "From Date is Empty", complition: {
                    
                  })
                 return false
             }
            
            guard self.toDate.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To Date is Empty", complition: {
                      
                    })
                 return false
             }
            
            guard greater == true  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To date cannot be before start date", complition: {
                      
                    })
                 return false
             }
            
            guard self.status.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: textfieldName + " " + "is Empty", complition: {
                      
                    })
                 return false
             }
        }
        else if (from == "subCate")
        {
            guard Reachability.isConnectedToNetwork() == true else{
                  AlertController.shared.offlineAlert(targetVc: self, complition: {
                    //Custom action code
                 })
                 return false
            }
            
            guard self.fromDate.text?.count != 0  else {
                AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "From Date is Empty", complition: {
                    
                  })
                 return false
             }
            
            guard self.toDate.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To Date is Empty", complition: {
                      
                    })
                 return false
             }
            
            guard greater == true  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To date cannot be before start date", complition: {
                      
                    })
                 return false
             }
            
            guard self.status.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: textfieldName + " " + "is Empty", complition: {
                      
                    })
                 return false
             }
        }
        else if (from == "location")
        {
            guard Reachability.isConnectedToNetwork() == true else{
                  AlertController.shared.offlineAlert(targetVc: self, complition: {
                    //Custom action code
                 })
                 return false
            }
            
            guard self.fromDate.text?.count != 0  else {
                AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "From Date is Empty", complition: {
                    
                  })
                 return false
             }
            
            guard self.toDate.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To Date is Empty", complition: {
                      
                    })
                 return false
             }
            
            guard greater == true  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To date cannot be before start date", complition: {
                      
                    })
                 return false
             }
            
            guard self.status.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: textfieldName + " " + "is Empty", complition: {
                      
                    })
                 return false
             }
        }
        else if (from == "meeting")
        {
            guard Reachability.isConnectedToNetwork() == true else{
                  AlertController.shared.offlineAlert(targetVc: self, complition: {
                    //Custom action code
                 })
                 return false
            }
            
            guard self.fromDate.text?.count != 0  else {
                AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "From Date is Empty", complition: {
                    
                  })
                 return false
             }
            
            guard self.toDate.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To Date is Empty", complition: {
                      
                    })
                 return false
             }
            
            guard greater == true  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To date cannot be before start date", complition: {
                      
                    })
                 return false
             }
        }
        else
        {
            guard Reachability.isConnectedToNetwork() == true else{
                  AlertController.shared.offlineAlert(targetVc: self, complition: {
                    //Custom action code
                 })
                 return false
            }
            
            guard self.fromDate.text?.count != 0  else {
                AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "From Date is Empty", complition: {
                    
                  })
                 return false
             }
            
            guard self.toDate.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To Date is Empty", complition: {
                      
                    })
                 return false
             }
            
            guard greater == true  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To date cannot be before start date", complition: {
                      
                    })
                 return false
             }
        }
        
        
          return true
    }
    
        

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_reportList")
        {
            let vc = segue.destination as! ReportList
            vc.from = sender as! String
            vc.paguthi = self.selectedPaguthuID
            vc.fromdate = fromDateFormatted
            vc.todate = toDateFormatted
            vc.status = self.status.text!
            vc.category = self.status.text!
            vc.sub_category = self.status.text!
        }
        else if (segue.identifier == "to_reportMeeting"){
            let vc = segue.destination as! ReportMeeting
            vc.fromdate = fromDateFormatted
            vc.todate = toDateFormatted
        }
        else if (segue.identifier == "to_reportStaff"){
            let vc = segue.destination as! ReportStaff
            vc.fromdate = fromDateFormatted
            vc.todate = toDateFormatted
        }
    }
    

}

extension ReportStatus : UIPickerViewDelegate, UIPickerViewDataSource, PaguthiView, CategoeryView, SubCategoeryView {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.status.isFirstResponder{
            if (from == "status")
            {
                return self.statusArr.count
            }
            else if (from == "categoery"){
                return self.categoeryName.count
            }
            else if (from == "subCate"){
                return self.subCategoeryName.count
            }
            else
            {
                return self.paguthiName.count
            }
        }
        else
        {
            return self.paguthiName.count
        }
//        else
//        {
//            return 0
//        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.status.isFirstResponder{
            if (from == "status")
            {
                return self.statusArr[row] // dropdown item
            }
            else if (from == "categoery"){
                return self.categoeryName[row]
            }
            else if (from == "subCate"){
                 return self.subCategoeryName[row]
            }
            else
            {
                return self.paguthiName[row]
            }
        }
        else
        {
            return self.paguthiName[row] // dropdo
        }
//        else{
//            return self.Cate[row] // dropdown item
//        }
    }

//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//         if self.status.isFirstResponder{
//            if (from == "status"){
//                status.text = self.statusArr[row] // selected item
//            }
//            else if (from == "categoery") {
//                status.text = self.categoeryName[row] // selected item
//                self.selectedPaguthuID = self.catgoeryId[row]
//                print(self.selectedPaguthuID)
//            }
//            else if (from == "subCate")
//            {
//                status.text = self.subCategoeryName[row] // selected item
//                self.selectedPaguthuID = self.subCatgoeryId[row]
//                print(self.selectedPaguthuID)
//            }
//            else
//            {
//                self.status.text = self.paguthiName[row]
//                self.selectedPaguthuID = self.paguthiId[row]
//            }
//         }
//         else if self.paguthi.isFirstResponder{
//            self.paguthi.text = self.paguthiName[row]
//            self.selectedPaguthuID = self.paguthiId[row]
//         }
//    }
    
    /*Presenter Delegate*/
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
            self.paguthiName.append(paguthi)
            self.paguthiId.append(id)
//            pickerView.reloadAllComponents()
         }
         self.paguthiName.insert("ALL", at: 0)
         self.paguthiId.insert("ALL", at: 0)
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
    }
    
    func setCategoery(categoery: [CategoeryData]) {
        categoeryData = categoery
        self.categoeryName.removeAll()
        self.catgoeryId.removeAll()
        for items in categoeryData
        {
            let cate = items.grievance_name
            let id = items.id
            self.categoeryName.append(cate)
            self.catgoeryId.append(id)
//            pickerView.reloadAllComponents()
        }
        self.categoeryName.insert("ALL", at: 0)
        self.catgoeryId.insert("ALL", at: 0)
//        self.pickerView.reloadAllComponents()
    }
    
    func setSubCategoery(subCategoery: [SubCategoeryData]) {
        subCategoeryData = subCategoery
        self.subCategoeryName.removeAll()
        self.subCatgoeryId.removeAll()
        for items in subCategoeryData
        {
            let cate = items.sub_category_name
            let id = items.id
            self.subCategoeryName.append(cate)
            self.subCatgoeryId.append(id)
//            pickerView.reloadAllComponents()
        }
        self.subCategoeryName.insert("ALL", at: 0)
        self.subCatgoeryId.insert("ALL", at: 0)
//        self.pickerView.reloadAllComponents()
    }
    
    func startLoadingCategoery()
    {
        self.view.activityStartAnimating()
    }
    
    func finishLoadingCategoery()
    {
        self.view.activityStopAnimating()
    }
    
    
    func setEmptyCategoery(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "empty", complition: {
         })
    }
    
    func setEmptySubCategoery(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "empty", complition: {
         })
    }
    
    func startLoadingSubCategoery (){
        self.view.activityStartAnimating()
    }
    
    func finishLoadingSubCategoery (){
        self.view.activityStopAnimating()
    }

}

