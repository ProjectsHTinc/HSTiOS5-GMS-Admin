//
//  ReportGrievanceVC.swift
//  GMS Admin
//
//  Created by HappysanziMac on 01/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class ReportGrievanceVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, PaguthiView, CategoeryView, SubCategoeryView,OfficeView, SeekerTypeView {
   

    @IBOutlet var pageTitle: UILabel!
    @IBOutlet var reportImageView: UIImageView!
    @IBOutlet var fromDate: TextFieldWithImage!
    @IBOutlet var toDate: TextFieldWithImage!
    @IBOutlet var category: TextFieldWithImage!
    @IBOutlet var subCategory: TextFieldWithImage!
    @IBOutlet var paguthi: TextFieldWithImage!
    @IBOutlet var office: TextFieldWithImage!
    @IBOutlet weak var seeker: TextFieldWithImage!
    
    let presenter = PaguthiPresenter(areaService: AreaService())
    var paguthiData = [PaguthiData]()
    
    let presenterSeekerType = SeekerTypePresenter(seekerTypeService: SeekerTypeService())
    var seekerTypeData = [SeekerTypeData]()
    
    let presenterOffice = OfficePresenter(officeService: OfficeService())
    var officeData = [OfficeData]()
    
    var presenterfestival = ReportFestivalPresenter(reportFestivalService: ReportFestivalService())
    var festivalData = [ReportFestivalData]()
    
    let presenterCategoery = CategoeryPresenter(categoeryService: CategoeryService())
    var categoeryData = [CategoeryData]()
    
    /*Get Sub Categoery List*/
    let presenterSubCategoery = SubCategoeryPresenter(subCategoeryService: SubCategoeryService())
    var subCategoeryData = [SubCategoeryData]()
    
    let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
    
    var fromDateFormatted = String()
    var toDateFormatted = String()
    var selectedFromDate = Date()
    var selectedToDate = Date()
    var paguthiName = [String]()
    var paguthiId = [String]()
    var selectedPaguthuID  = String()
    
    var seekerIDArr = [String]()
    var seekerNameArr = [String]()
    
    var selectedseekerTypeId = String()
    var officeName = [String]()
    var officeId = [String]()
    var categoeryName = [String]()
    var catgoeryId = [String]()
    var from = String()
    var selectedCategoryId = String()
    var selectedSubCategoryId = String()
    var subCategoeryName = [String]()
    var subCatgoeryId = [String]()
    var selectedofficeID  = String()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
     
        self.showDatePicker()
        self.createPickerView()
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        
      self.callAPIOffice ()
      self.callAPIPaguthi()
      self.callAPICategoery ()
      self.callAPISubCategoery()
      self.callAPISeeker ()
    
    }
    
    @IBAction func toGrievanceAction(_ sender: Any) {
        
        from = "grievance"
        self.performSegue(withIdentifier: "to_Grievance", sender: self.from)
    }
    
    @IBAction func clearAction(_ sender: Any) {
        
        self.fromDate.text = ""
        self.toDate.text = ""
        self.seeker.text = ""
        self.paguthi.text = ""
        self.office.text = ""
        self.category.text = ""
        self.subCategory.text = ""
    }
    
    func callAPICategoery ()
    {
        presenterCategoery.attachView(view: self)
        presenterCategoery.getCategoery(user_id: GlobalVariables.shared.user_id,dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    func callAPISeeker ()
    {
        presenterSeekerType.attachView(view: self)
        presenterSeekerType.getSeekerType(user_id: GlobalVariables.shared.user_id,dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    func callAPISubCategoery ()
    {
        presenterSubCategoery.attachView(view: self)
        presenterSubCategoery.getSubCate(user_id: GlobalVariables.shared.user_id,dynamic_db:GlobalVariables.shared.dynamic_db)
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
        
    func showDatePicker(){
       //Formate Date
       datePicker.datePickerMode = .date
       datePicker.backgroundColor = UIColor.white
       datePicker.setValue(UIColor.black, forKeyPath: "textColor")
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        
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
        
    @objc func cancelDatePicker() {
       self.view.endEditing(true)
     }
    
    func createPickerView() {
         pickerView.dataSource = self
         pickerView.delegate = self
         pickerView.backgroundColor = UIColor.white
         pickerView.setValue(UIColor.black, forKeyPath: "textColor")
       
         paguthi.inputView = pickerView
         office.inputView = pickerView
         category.inputView = pickerView
         subCategory.inputView = pickerView
         seeker.inputView = pickerView
        
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
         category.inputAccessoryView = toolBar
         subCategory.inputAccessoryView = toolBar
         seeker.inputAccessoryView = toolBar
        
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
      else if self.category.isFirstResponder{
        self.category.text = self.categoeryName[row]
//          self.selectedofficeID = self.officeId[row]
      }
      else if self.subCategory.isFirstResponder{
        self.subCategory.text = self.subCategoeryName[row]
//          self.selectedofficeID = self.officeId[row]
      }
      else if self.seeker.isFirstResponder{
        self.seeker.text = self.seekerNameArr[row]
          self.selectedseekerTypeId = self.seekerIDArr[row]
      }
        
          view.endEditing(true)
    }
    
    @objc func cancel() {
          view.endEditing(true)
    }
    
    func CheckValuesAreEmpty () -> Bool{
        
        let greater = selectedFromDate.timeIntervalSince1970 < selectedToDate.timeIntervalSince1970
      
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
            
            guard self.paguthi.text?.count != 0  else {
                 AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Paguthi is Empty", complition: {
                      
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
       else if paguthi.isFirstResponder
        {
            return self.paguthiName.count
        }
       else if category.isFirstResponder
       {
          return self.categoeryName.count
       }
       else if subCategory.isFirstResponder
       {
          return self.subCategoeryName.count
        }
        else {
        return self.seekerNameArr.count
       }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      
            if office.isFirstResponder
            {
                return self.officeName[row]
            }
            else if paguthi.isFirstResponder {
                return self.paguthiName[row]
            }
            else if category.isFirstResponder{
              return self.categoeryName[row]
            }
            else if subCategory.isFirstResponder{
              return self.subCategoeryName[row]
            }
            else {
                return self.seekerNameArr[row]
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
    
    func setCategoery(categoery: [CategoeryData]) {
        categoeryData = categoery
        self.categoeryName.removeAll()
        self.catgoeryId.removeAll()
        self.seekerIDArr.removeAll()
        for items in categoeryData
        {
            let cate = items.grievance_name
            let id = items.id
            let seekerId = items.seeker_id
            self.categoeryName.append(cate.capitalized)
            self.catgoeryId.append(id)
            self.seekerIDArr.append(seekerId)
            
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
            self.subCategoeryName.append(cate.capitalized)
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
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_Grievance")
        {
            let vc = segue.destination as! StatusReportList
            vc.from = sender as! String
            vc.paguthi = self.selectedPaguthuID
            vc.office = self.selectedofficeID
            vc.fromdate = fromDateFormatted
            vc.todate = toDateFormatted
            vc.category = selectedCategoryId
            vc.sub_category = selectedSubCategoryId
            vc.seekerId = selectedseekerTypeId
//            vc.status = self.status.text!
//            vc.category = self.status.text!
//            vc.sub_category = self.status.text!
        }
//        else if (segue.identifier == "to_reportMeeting"){
//            let vc = segue.destination as! ReportMeeting
//            vc.fromdate = fromDateFormatted
//            vc.todate = toDateFormatted
//        }
//        else if (segue.identifier == "to_reportStaff"){
//            let vc = segue.destination as! ReportStaff
//            vc.fromdate = fromDateFormatted
//            vc.todate = toDateFormatted
//        }
    }
    
    func setSeeker(subCategoery: [SeekerTypeData]) {
//        var seekerIDArr = [String]()
        seekerTypeData = subCategoery
        self.seekerNameArr.removeAll()
        self.seekerIDArr.removeAll()
        
        for items in seekerTypeData {
            let seekerName = items.seeker_info
            let id = items.id
            
            self.seekerNameArr.append(seekerName)
            self.seekerIDArr.append(id)
        }
        self.seekerNameArr.insert("ALL", at: 0)
        self.seekerIDArr.insert("ALL", at: 0)
    }
}

