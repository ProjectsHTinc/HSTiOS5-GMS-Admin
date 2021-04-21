//
//  GreetingCount.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class GreetingCount: UIViewController,GreetingCountView {
    
    @IBOutlet weak var greetingCount: UILabel!
    @IBOutlet weak var birthdayWishesPercentage: UILabel!
    @IBOutlet weak var festivalWishesPercentage: UILabel!
    @IBOutlet weak var diwaliPercentage: UILabel!
    @IBOutlet weak var christmasPercentage: UILabel!
    @IBOutlet weak var ramzanPercentage: UILabel!
    @IBOutlet weak var birthdayWishesCount: UILabel!
    @IBOutlet weak var festivalWishesCount: UILabel!
    @IBOutlet weak var diwaliCount: UILabel!
    @IBOutlet weak var christmasCount: UILabel!
    @IBOutlet weak var ramzanCount: UILabel!
    
    var paguthi_Id = String()
    var resp = [GreetingCountData]()
    let presenterTm = GreetingCountPresenter(greetingCountService: GreetingCountService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.CallAPIGreeting()
        // Do any additional setup after loading the view.
    }
    
    func CallAPIGreeting ()
    {
        presenterTm.attachView(view: self)
        presenterTm.getGreetingCount(paguthi: paguthi_Id, from_date: GlobalVariables.shared.widgetFromDate, to_date: GlobalVariables.shared.widgetToDate)
    }
    
    func startLoadingCi() {
//
    }
    
    func finishLoadingCI() {
//
    }
    
    func setCI(greetingCountData: [GreetingCountData]) {
    
        resp = greetingCountData
   
        self.greetingCount.text = ("Geeeting Count - \(GlobalVariables.shared.total_greetings)")
        self.festivalWishesCount.text = GlobalVariables.shared.festival_wishes_count
        self.birthdayWishesCount.text = GlobalVariables.shared.birthday_wish_count
        self.festivalWishesPercentage.text = greetingCountData[0].festival_wishes_percentage
        self.ramzanCount.text = greetingCountData[0].festival_wish_cnt
    }
    
    func setEmptyCI(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }

    @IBAction func dismissAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
//var festival_name: String?
//var festival_wish_cnt: String?
//var festival_wishes_percentage : String?
