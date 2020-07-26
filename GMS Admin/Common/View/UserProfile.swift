//
//  UserProfile.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class UserProfile: UIViewController, ProfileDetailsView, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    /*Get User Details List*/
    let presenter = ProfileDetailPresenter(profileDetailService:ProfileDetailService())
    var userData = [ProfileDetailsData]()
    
    var imagePicker = UIImagePickerController()
    var uploadedImage = UIImage()

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var name: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var emailId: UITextField!
    @IBOutlet var genderSegment: UISegmentedControl!
    @IBOutlet var address: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.callAPI()
        
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
         self.name.text = full_name
         self.phone.text = phone_number
         self.emailId.text = email_id
         let seg = gender
         if(seg == "M"){
            genderSegment.selectedSegmentIndex = 0
         }
         else
         {
            genderSegment.selectedSegmentIndex = 1
         }
         self.address.text = address
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
         picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func genderSegement(_ sender: Any) {
        
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
