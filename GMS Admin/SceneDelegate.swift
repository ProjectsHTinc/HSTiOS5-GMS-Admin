//
//  SceneDelegate.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 27/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        self.loadBaseContrloler()

    }
    
    func loadBaseContrloler ()
    {
        let user_id = UserDefaults.standard.object(forKey: UserDefaultsKey.userIDkey.rawValue) ?? ""
        let client_api_url = UserDefaults.standard.object(forKey: UserDefaultsKey.clientAPiUrlkey.rawValue) ?? ""
        let userName = UserDefaults.standard.object(forKey: UserDefaultsKey.userNamekey.rawValue) ?? ""
        let userLocation = UserDefaults.standard.object(forKey: UserDefaultsKey.userLocationkey.rawValue) ?? ""
        let userImage = UserDefaults.standard.object(forKey: UserDefaultsKey.userImagekey.rawValue) ?? ""
        let constituent_id = UserDefaults.standard.object(forKey: UserDefaultsKey.constituentIDkey.rawValue) ?? ""
        let userRole = UserDefaults.standard.object(forKey: UserDefaultsKey.userRolekey.rawValue) ?? ""
        let constituencyName = UserDefaults.standard.object(forKey: UserDefaultsKey.constituencyNamekey.rawValue) ?? ""
        if user_id as! String == ""
        {
            guard let window = self.window else { return }
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "login") as! Login
            window.rootViewController = newViewcontroller
            window.makeKeyAndVisible()
        }
        else
        {
            GlobalVariables.shared.CLIENTURL = client_api_url as! String
            GlobalVariables.shared.user_id = user_id as! String
            GlobalVariables.shared.user_name = userName as! String
            GlobalVariables.shared.user_location = userLocation as! String
            GlobalVariables.shared.user_Image = userImage as! String
            GlobalVariables.shared.constituent_Id = constituent_id as! String
            GlobalVariables.shared.user_role = userRole as! String
            GlobalVariables.shared.selectedConstituencyName = constituencyName as! String
            guard let window = self.window else { return }
            self.window = window
              // Set initial view controller from Main storyboard as root view controller of UIWindow
            self.window?.rootViewController = UIStoryboard(name: "DashBoard", bundle: nil).instantiateInitialViewController()
              // Present window to screen
            self.window?.makeKeyAndVisible()
        }
    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

