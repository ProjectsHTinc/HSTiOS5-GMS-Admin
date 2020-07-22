//
//  AlertController.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 11/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class AlertController: NSObject {

     static let shared: AlertController = AlertController()
     static let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //MARK: ALERT
    
    func showAlert(targetVc: UIViewController, title: String, message: String, complition: @escaping ()->()){
        var message = message
        var title = title
        title = NSLocalizedString(title, comment: "")
        message = NSLocalizedString(message, comment: "")
        let alert = UIAlertController(title: title,message: message,preferredStyle:UIAlertController.Style.alert)
        let okButton = UIAlertAction(title:"OK",style: UIAlertAction.Style.default,handler:{
            (alert: UIAlertAction!)  in
            DispatchQueue.main.async {
                complition()
            }
        })
        alert.addAction(okButton)
        targetVc.present(alert, animated: true, completion: nil)
    }
    
    func alertWithButtons (targetVc:UIViewController, title:String, message:String, okButtonTitle:String, cancelButtonTitle:String, complition: @escaping ()->())
    {
        var message = message
        var title = title
        var okButtonTitle = okButtonTitle
        var cancelButtonTitle = cancelButtonTitle
        title = NSLocalizedString(title, comment: "")
        message = NSLocalizedString(message, comment: "")
        okButtonTitle = NSLocalizedString(title, comment: "")
        cancelButtonTitle = NSLocalizedString(message, comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
        }))
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        targetVc.present(alert, animated: true, completion: nil)
    }
    
    func offlineAlert (targetVc:UIViewController, complition: @escaping ()->()){
        let alert = UIAlertController(title: "Error!",message: "Device is offline. Please check the network connection and try again.", preferredStyle:UIAlertController.Style.alert)
        let okButton = UIAlertAction(title:"OK",style: UIAlertAction.Style.default,handler:{
            (alert: UIAlertAction!)  in
            DispatchQueue.main.async {
                complition()
            }
        })
        alert.addAction(okButton)
        targetVc.present(alert, animated: true, completion: nil)
    }
}
