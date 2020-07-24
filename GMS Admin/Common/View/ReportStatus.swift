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
        if (from == "status"){
            self.reportImageView.image = UIImage(named: "ReportStatus")
            self.statusArr = ["ALL","REQUESTED","COMPLETED"]
        }
        else if (from == "categoery"){
            self.reportImageView.image = UIImage(named: "ReportCategoery")
            status.attributedPlaceholder =
            NSAttributedString(string: "Select Categoery", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 188 / 255, green: 188 / 255, blue: 188 / 255, alpha: 1.0)])
            self.Cate = ["ALL","1"]
            self.downArrowPaguthi.isHidden = true
            self.paguthiHeight.constant = 0

        }
        else if (from == "subCate"){
            self.reportImageView.image = UIImage(named:"ReportSubcat")
            status.attributedPlaceholder =
            NSAttributedString(string: "  Select Sub Categoery", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 188 / 255, green: 188 / 255, blue: 188 / 255, alpha: 1.0)])
            self.subCat = ["ALL","1"]
            self.downArrowPaguthi.isHidden = true
            self.paguthiHeight.constant = 0
        }
        else if (from == "location"){
            self.reportImageView.image = UIImage(named: "ReportLocation")
            status.attributedPlaceholder =
            NSAttributedString(string: "Select Location", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 188 / 255, green: 188 / 255, blue: 188 / 255, alpha: 1.0)])
            self.downArrowPaguthi.isHidden = true
            self.paguthiHeight.constant = 0
        }
        else if (from == "meeting"){
            self.reportImageView.image = UIImage(named: "ReportMeeting")
            self.downArrowStatus.isHidden = true
            self.downArrowPaguthi.isHidden = true
            self.statusHeight.constant = 0
            self.paguthiHeight.constant = 0
        }
        else if (from == "staff"){
            self.reportImageView.image = UIImage(named: "ReportStaff")
            self.downArrowStatus.isHidden = true
            self.downArrowPaguthi.isHidden = true
            self.statusHeight.constant = 0
            self.paguthiHeight.constant = 0
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

      //ToolBar
      let toolbar = UIToolbar();
      toolbar.sizeToFit()
      let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

     toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

     fromDate.inputAccessoryView = toolbar
     fromDate.inputView = datePicker
        
     toDate.inputAccessoryView = toolbar
     toDate.inputView = datePicker

    }
    
     @objc func donedatePicker(){
        if fromDate.isFirstResponder
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            fromDate.text = formatter.string(from: datePicker.date)
            selectedFromDate = datePicker.date
            self.view.endEditing(true)
        }
        else
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            toDate.text = formatter.string(from: datePicker.date)
            selectedToDate = datePicker.date
            self.view.endEditing(true)
        }

    }
    
    @objc func cancelDatePicker(){
       self.view.endEditing(true)
     }
    
    func createPickerView() {
           pickerView.dataSource = self
           pickerView.delegate = self
           status.inputView = pickerView
           paguthi.inputView = pickerView
    }
    
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       status.inputAccessoryView = toolBar
       paguthi.inputAccessoryView = toolBar

    }
    
    @objc func action() {
          view.endEditing(true)
    }
    
    @IBAction func search(_ sender: Any)
    {
        guard CheckValuesAreEmpty () else {
              return
        }
        if (from == "status")
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
                AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "", complition: {
                    
                  })
                 return false
             }
            
            guard self.toDate.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "", complition: {
                      
                    })
                 return false
             }
            
            guard greater == true  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "From date", complition: {
                      
                    })
                 return false
             }
            
            guard self.status.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "", complition: {
                      
                    })
                 return false
             }
            
            guard self.paguthi.text?.count != 0  else {
                 AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "", complition: {
                      
                    })
                 return false
             }
        }
        else
        {
            
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
            vc.fromdate = self.fromDate.text!
            vc.todate = self.toDate.text!
            vc.status = self.status.text!
        }
        else if (segue.identifier == "to_reportMeeting"){
            let vc = segue.destination as! ReportMeeting
            vc.fromdate = self.fromDate.text!
            vc.todate = self.toDate.text!
        }
        else if (segue.identifier == "to_reportStaff"){
            let vc = segue.destination as! ReportStaff
            vc.fromdate = self.fromDate.text!
            vc.todate = self.toDate.text!
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
        else if self.paguthi.isFirstResponder
        {
            return self.paguthiName.count
        }
        else
        {
            return self.Cate.count
        }
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
        else if self.paguthi.isFirstResponder
        {
            return self.paguthiName[row] // dropdo
        }
        else{
            return self.Cate[row] // dropdown item
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
    }
    
    /*Presenter Delegate*/
    func startLoading(){
        self.view.activityStartAnimating()
    }
    
    func finishLoading(){
         self.view.activityStopAnimating()
    }
    
    func setPaguthi(paguthi: [PaguthiData]) {
         paguthiData = paguthi
        for items in paguthiData
        {
            let paguthi = items.paguthi_name
            let id = items.id
            self.paguthiName.append(paguthi)
            self.paguthiId.append(id)
            pickerView.reloadAllComponents()
        }
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
    }
    
    func setCategoery(categoery: [CategoeryData]) {
        categoeryData = categoery
        for items in categoeryData
        {
            let cate = items.grievance_name
            let id = items.id
            self.categoeryName.append(cate)
            self.catgoeryId.append(id)
            pickerView.reloadAllComponents()
        }
        self.pickerView.reloadAllComponents()
    }
    
    func setSubCategoery(subCategoery: [SubCategoeryData]) {
        subCategoeryData = subCategoery
        for items in subCategoeryData
        {
            let cate = items.sub_category_name
            let id = items.id
            self.subCategoeryName.append(cate)
            self.subCatgoeryId.append(id)
            pickerView.reloadAllComponents()
        }
        self.pickerView.reloadAllComponents()
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

