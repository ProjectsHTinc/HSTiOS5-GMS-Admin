//
//  UserProfile.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import Alamofire

class UserProfile: UIViewController, ProfileDetailsView, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    /*Get User Details List*/
    let presenter = ProfileDetailPresenter(profileDetailService:ProfileDetailService())
    var userData = [ProfileDetailsData]()
    
    /*Get User Update List*/
    let presenterUpdate = ProfileUpdatePresenter(profileUpdateService:ProfileUpdateService())
    var profileUpdate = [ProfileUpdateData]()
    
    var imagePicker = UIImagePickerController()
    var uploadedImage = UIImage()
    var selectedSegmentValue = String()

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var name: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var emailId: UITextField!
    @IBOutlet var genderSegment: UISegmentedControl!
    @IBOutlet var address: UITextView!
    @IBOutlet var saveProfileOutlet: UIButton!
    @IBOutlet var userImageOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.callAPI()
        /*Set Delegates*/
        self.name.delegate = self
        self.phone.delegate = self
        self.emailId.delegate = self
        self.address.delegate = self
        self.addCustomizedBackBtn(title:"  Edit Profile")
        self.hideKeyboardWhenTappedAround()
    }
    
    func callAPI (){
        presenter.attachView(view: self)
        presenter.getProfileDetails(user_id: GlobalVariables.shared.user_id)
    }
    
    func setUpSegmentControl (){
        genderSegment.backgroundColor = .white
//      genderSegment.tintColor = .white
        genderSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 13) as Any], for: .normal)
        genderSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        genderSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        genderSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 13) as Any], for: .selected)
    }
    
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setProfileDetails(user_id:String,user_role:String,constituency_id:String,pugathi_id:String,full_name:String,phone_number:String,email_id:String,gender:String,address:String,picture_url:String) {
         self.userImage.sd_setImage(with: URL(string: picture_url), placeholderImage: UIImage(named: "placeholder.png"))
         self.name.text = full_name.capitalized
         self.phone.text = phone_number
         self.emailId.text = email_id.capitalized
         let seg = gender
         let userRole = user_role
         if userRole == "2"{
            self.saveProfileOutlet.isHidden = true
            self.name.isEnabled = false
            self.phone.isEnabled = false
            self.emailId.isEnabled = false
            self.saveProfileOutlet.isEnabled = false
            self.address.isEditable = false
            self.genderSegment.isEnabled = false
            self.userImageOutlet.isEnabled = false
         }
         else{
            self.saveProfileOutlet.isHidden = false
            self.name.isEnabled = true
            self.phone.isEnabled = true
            self.emailId.isEnabled = true
            self.saveProfileOutlet.isEnabled = true
            self.address.isEditable = true
            self.genderSegment.isEnabled = true
            self.userImageOutlet.isEnabled = true
         }
         if(seg == "M"){
            genderSegment.selectedSegmentIndex = 0
            selectedSegmentValue = "M"
         }
         else{
            genderSegment.selectedSegmentIndex = 1
            selectedSegmentValue = "F"
         }
         self.address.text = address.capitalized
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
    }
    
    @IBAction func changeImage(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                self.openCamera()
        }))
            
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
                self.openGallary()
        }))
            
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as? UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
            
        self.present(alert, animated: true, completion: nil)
    }
        
    func openCamera(){
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
        
    //MARK: - Choose image from camera roll
        
    func openGallary(){
         imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
         //If you dont want to edit the photo then you can set allowsEditing to false
         imagePicker.allowsEditing = true
         imagePicker.delegate = self
         self.present(imagePicker, animated: true, completion: nil)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         uploadedImage = (info[.originalImage] as? UIImage)!
         if  let editedImage = info[.originalImage] as? UIImage
         {
             self.userImage.image = editedImage
             self.userImage.clipsToBounds = true
         }
         //Dismiss the UIImagePicker after selection
         self.picUploadAPI()
         picker.dismiss(animated: true, completion: nil)
    }
    
    func picUploadAPI ()
    {
        let imgData = uploadedImage.jpegData(compressionQuality: 0.75)
        if imgData == nil
        {
              //self.performSegue(withIdentifier: "back_selectPage", sender: self)
        }
        else
        {
            let functionName = "apiios/profilePictureUpload/"
            let baseUrl = GlobalVariables.shared.CLIENTURL + functionName + GlobalVariables.shared.user_id
            let url = URL(string: baseUrl)!
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData!, withName: "user_pic",fileName: "file.jpg", mimeType: "image/jpg")
            },
             to:url)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                       upload.uploadProgress(closure: { (progress) in
                           print("Upload Progress: \(progress.fractionCompleted)")
                       })
                       upload.responseJSON { response in
                       print(response.result.value as Any)
                       //ActivityIndicator().hideActivityIndicator(uiView: self.view)
                       let JSON = response.result.value as? [String: Any]
                       let msg = JSON?["msg"] as? String
                       let status = JSON?["status"] as? String
                       GlobalVariables.shared.user_Image = (JSON?["picture_url"] as? String)!
                       print(msg!,status!,GlobalVariables.shared.user_Image)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        }
    }
    
    @IBAction func saveProfile(_ sender: Any)
    {
        self.updateAPI(name: self.name.text!, phone: self.phone.text!, emailId: self.emailId.text!, genderSegment: self.selectedSegmentValue, address: self.address.text!)
    }
    
    @IBAction func genderSegement(_ sender: Any) {
        
        if (genderSegment.selectedSegmentIndex == 0)
        {
            genderSegment.selectedSegmentIndex = 0
            selectedSegmentValue = "M"
        }
        else
        {
            genderSegment.selectedSegmentIndex = 1
            selectedSegmentValue = "F"
        }
    }
    
    func updateAPI (name:String,phone:String,emailId:String,genderSegment:String,address:String)
    {
        presenterUpdate.attachView(view: self)
        presenterUpdate.getProfileUpdate(user_id: GlobalVariables.shared.user_id, name: name, address: address, phone: phone, email: emailId, gender: genderSegment)
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

extension UserProfile : ProfileUpdatesView, UITextFieldDelegate, UITextViewDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.name){
            self.phone.becomeFirstResponder()
        }
        else if (textField == self.phone){
            self.emailId.becomeFirstResponder()
        }
        else if (textField == self.emailId){
            self.address.becomeFirstResponder()
        }

        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if name.isFirstResponder
        {
            let maxLength = 30
            let currentString: NSString = name.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if phone.isFirstResponder
        {
            let maxLength = 10
            let currentString: NSString = phone.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if emailId.isFirstResponder
        {
            let maxLength = 30
            let currentString: NSString = emailId.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else
        {
            let maxLength = 240
            let currentString: NSString = address.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }

    }
    
    func startLoadingUpdate() {
        //
    }
    
    func finishLoadingUpdate() {
        //
    }
    
    func setProfileUpdate(msg: String, status: String) {
        if  status == "success"{
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: msg, complition: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    func setEmptyUpdate(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
    }
    
    
    
}
