//
//  AppDelegate.swift
//  iSeeMovie
//
//  Created by Tais on 7/10/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var indicatorView: UIActivityIndicatorView?
    var loaderBgView: UIView?
    
    static var delegate = UIApplication.shared.delegate as! AppDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        _ = ConfigurationManager.sharedInstance
        setNavBarAppearance()
        return true
    }
    
    /// Customizing the appearance of the navigation bar
    func setNavBarAppearance() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        let navigationBarAppearance = UINavigationBar.appearance()
       // navigationBarAppearance.tintColor = UIColor.black//UIColor(red: 255.0/255.0, green: 153.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        navigationBarAppearance.barTintColor = UIColor.black //UIColor(red: 25.0/255.0, green: 25.0/255.0, blue: 25.0/255.0, alpha: 1.0)
//        navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 255.0/255.0, green: 153.0/255.0, blue: 51.0/255.0, alpha: 1.0)]
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.shadowImage = UIImage()
        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor = UIColor.black
        tabBarAppearance.isTranslucent = false
        
    }
}

//MARK:- Setup Activity Indicator
//MARK:-
extension AppDelegate {
    func showIndicatorView() {
        if loaderBgView == nil {
            loaderBgView = UIView(frame: (self.window?.frame)!)
            loaderBgView?.backgroundColor = UIColor(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, alpha: 0.5)
            
            indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            indicatorView?.style = UIActivityIndicatorView.Style.large
            indicatorView?.center = (loaderBgView?.center)!
            loaderBgView?.addSubview(indicatorView!)
        }
        if let view = loaderBgView {
            indicatorView?.startAnimating()
            self.window?.addSubview(view)
        }
    }
    
    func hideIndicatorView() {
        if let view = loaderBgView {
            indicatorView?.stopAnimating()
            view.removeFromSuperview()
        }
    }
}

