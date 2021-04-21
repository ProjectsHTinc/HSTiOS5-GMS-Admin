//
//  WidgetVedio.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class WidgetVedio: UIViewController,VedioCountView {
    
    @IBOutlet weak var vedioCount: UILabel!
    @IBOutlet weak var office1Percentage: UILabel!
    @IBOutlet weak var office2Percentage: UILabel!
    @IBOutlet weak var office3Count: UILabel!    
    @IBOutlet weak var office2Count: UILabel!
    @IBOutlet weak var office3Percentage: UILabel!
    @IBOutlet weak var office1Count: UILabel!
    @IBOutlet weak var office4Percentage: UILabel!
    @IBOutlet weak var office5Percentage: UILabel!
    @IBOutlet weak var office6Percentage: UILabel!
    @IBOutlet weak var office7Percentage: UILabel!
    @IBOutlet weak var office8Percentage: UILabel!
    @IBOutlet weak var office9Percentage: UILabel!
    @IBOutlet weak var office4Count: UILabel!
    @IBOutlet weak var office5Count: UILabel!
    @IBOutlet weak var office6Count: UILabel!
    @IBOutlet weak var office7Count: UILabel!
    @IBOutlet weak var office8Count: UILabel!
    @IBOutlet weak var office9Count: UILabel!
    
    var paguthi_Id = String()
    let presenterTm = VedioCountPresenter(vedioCountService: VedioCountService())
    var CMData = [VedioCountData]()
        override func viewDidLoad() {
        super.viewDidLoad()
            
            self.CallAPIVolunteer()

        // Do any additional setup after loading the view.
    }
    
    func CallAPIVolunteer ()
    {
        presenterTm.attachView(view: self)
        presenterTm.getvedioCount(paguthi: paguthi_Id, from_date: GlobalVariables.shared.widgetFromDate, to_date: GlobalVariables.shared.widgetToDate)
    }


    @IBAction func dissmissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
     
    func startLoadingCi() {
//
    }
    
    func finishLoadingCI() {
//
    }
    
    func setCI(vedioCountData: [VedioCountData]) {
        
        CMData = vedioCountData
       let VedioCount = String(GlobalVariables.shared.vedioCount)
        self.vedioCount.text = ("Vedio Count - \(VedioCount)")
        self.office1Percentage.text = "\(vedioCountData[0].office_name!)+(\(vedioCountData[0].video_percentage!))%)"
        self.office2Percentage.text = "\(vedioCountData[1].office_name!)+(\(vedioCountData[1].video_percentage!))%)"
        self.office3Percentage.text = "\(vedioCountData[2].office_name!)+(\(vedioCountData[2].video_percentage!))%)"
        self.office4Percentage.text = "\(vedioCountData[3].office_name!)+(\(vedioCountData[3].video_percentage!))%)"
        self.office5Percentage.text = "\(vedioCountData[4].office_name!)+(\(vedioCountData[4].video_percentage!))%)"
        self.office6Percentage.text = "\(vedioCountData[5].office_name!)+(\(vedioCountData[5].video_percentage!))%)"
        self.office7Percentage.text = "\(vedioCountData[6].office_name!)+(\(vedioCountData[6].video_percentage!))%)"
        self.office8Percentage.text = "\(vedioCountData[7].office_name!)+(\(vedioCountData[7].video_percentage!))%)"
        self.office9Percentage.text = "\(vedioCountData[8].office_name!)+(\(vedioCountData[8].video_percentage!))%)"
        
        self.office1Count.text = vedioCountData[0].video_cnt!
        self.office2Count.text = vedioCountData[1].video_cnt!
        self.office3Count.text = vedioCountData[2].video_cnt!
        self.office4Count.text = vedioCountData[3].video_cnt!
        self.office5Count.text = vedioCountData[4].video_cnt!
        self.office6Count.text = vedioCountData[5].video_cnt!
        self.office7Count.text = vedioCountData[6].video_cnt!
        self.office8Count.text = vedioCountData[7].video_cnt!
        self.office9Count.text = vedioCountData[8].video_cnt!
        
        }
    
    func setEmptyCI(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
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
