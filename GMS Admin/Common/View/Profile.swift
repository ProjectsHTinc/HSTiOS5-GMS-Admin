//
//  Profile.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SDWebImage

class Profile: UIViewController {
    
    var consprofiledata = [ConstituentDetailData]()
//    var profiledata = [GreivancesAllData]()
    /*Get ConsDetail Data */
    let presenter = ConstituentDetailPresenter(constituentDetailService: ConstituentDetailService())
    var constituentdetail = [ConstituentDetailData]()

    var container: Container!
    var From = String()
    var id = String()


    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userNumber: UILabel!
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var containerViewOne: UIView!
    @IBOutlet var containerViewTwo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard checkInterConnection () else {
            return
        }
        self.view.isHidden = false
        self.navigationItem.title = "Profile"
        if GlobalVariables.shared.profGrivance == "GreiAll"
        {
            self.callAPIConstituentDetail()
        }
        else
        {
            consprofiledata = UserDefaults.standard.getConsProfileInfo(ConstituentDetailData.self, forKey: UserDefaultsKey.ConsProfilekey.rawValue)
            self.setAllValues()
        }
        self.setUpControl ()
    }
    
    func callAPIConstituentDetail ()
    {
        print(id)
        presenter.attachView(view: self)
        presenter.getConstituentDetailData(constituent_id: id)
    }
    
    func checkInterConnection () -> Bool
    {
        guard Reachability.isConnectedToNetwork() == true else{
              self.view.isHidden = true
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
              return false
        }
              return true
    }
    
    
    func setUpControl ()
    {
        if GlobalVariables.shared.profGrivance == "GreiAll"
        {
            segmentControl.setTitle("Profile", forSegmentAt: 0)
            segmentControl.setTitle("Constituency", forSegmentAt: 1)
            segmentControl.setTitle("Interaction", forSegmentAt: 2)
            segmentControl.selectedSegmentIndex = 0
            segmentControl.backgroundColor = UIColor.white
            segmentControl.tintColor = UIColor.white
            segmentControl.setTitleTextAttributes([
                NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
                NSAttributedString.Key.foregroundColor: UIColor.black
                ], for: .normal)

            segmentControl.setTitleTextAttributes([
                NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ], for: .selected)
        }
        else
        {
            segmentControl.setTitle("Profile", forSegmentAt: 0)
            segmentControl.setTitle("Constituency", forSegmentAt: 1)
            segmentControl.removeSegment(at: 2, animated: false)
            segmentControl.selectedSegmentIndex = 0
            segmentControl.backgroundColor = UIColor.white
            segmentControl.tintColor = UIColor.white
            segmentControl.setTitleTextAttributes([
                NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
                NSAttributedString.Key.foregroundColor: UIColor.black
                ], for: .normal)

            segmentControl.setTitleTextAttributes([
                NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ], for: .selected)
        }

    }
    
    func setAllValues ()
    {
        if GlobalVariables.shared.profGrivance == "GreiAll"
        {
            self.userImageView.sd_setImage(with: URL(string: Globals.imageUrl + consprofiledata[0].profile_pic!), placeholderImage: UIImage(named: "placeholder.png"))
            self.userName.text = consprofiledata[0].full_name?.capitalized
            self.userNumber.text = consprofiledata[0].paguthi_name?.capitalized
        }
        else
        {
            self.userImageView.sd_setImage(with: URL(string: Globals.imageUrl + consprofiledata[0].profile_pic!), placeholderImage: UIImage(named: "placeholder.png"))
            self.userName.text = consprofiledata[0].full_name?.capitalized
            self.userNumber.text = consprofiledata[0].paguthi_name?.capitalized
        }

    }
    
    @IBAction func segmentAction(_ sender: Any) {
        if (segmentControl.selectedSegmentIndex == 0)
        {
            container!.segueIdentifierReceivedFromParent("profile")
        }
        else if (segmentControl.selectedSegmentIndex == 1)
        {
            GlobalVariables.shared.profGrivance = From
            container!.segueIdentifierReceivedFromParent("constituencyInfo")
        }
        else
        {
            let vc = InterAction()
            vc.selectedconstitunecyId = self.id
            container!.segueIdentifierReceivedFromParent("interaction")
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "container" {
            container = (segue.destination as! Container)
            //For adding animation to the transition of containerviews you can use container's object property
            // animationDurationWithOptions and pass in the time duration and transition animation option as a tuple
            // Animations that can be used
            // .transitionFlipFromLeft, .transitionFlipFromRight, .transitionCurlUp
            // .transitionCurlDown, .transitionCrossDissolve, .transitionFlipFromTop
            container.animationDurationWithOptions = (0.5, .transitionCrossDissolve)
        }
    }
}


extension Profile: ConstituentDetailView{
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setConstituentDetailData(constituentDetail: [ConstituentDetailData]) {
         consprofiledata = constituentDetail
         self.setAllValues()
    }
    
    func setEmpty(errorMessage: String) {
        //
    }
    
    
}
