//
//  TabBarViewController.swift
//  iSeeMovies
//
//  Created by Tais on 7/8/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController, UITabBarDelegate {
    @IBOutlet weak var contentView: UIView!
    @IBInspectable var numberOfTabsToLoad: Int = 0
    @IBOutlet var bottomTabbar: UITabBar?
    
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    
    var viewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        (0..<numberOfTabsToLoad).forEach {
            self.performSegue(withIdentifier: "tab\($0)", sender: nil)
        }
        activeViewController = viewControllers[0]
        if let items = bottomTabbar?.items, items.count > 0 {
            bottomTabbar?.selectedItem = items[0]
        }
    }
}

//MARK: - Add Remove Child View Controller
//MARK: -
extension TabBarViewController {
    private func updateActiveViewController() {
        if let activeVC = activeViewController {
            addChild(activeVC)
            activeVC.view.frame = contentView.bounds
            contentView.addSubview(activeVC.view)
            activeVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            activeVC.didMove(toParent: self)
        }
    }
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inActiveVC = inactiveViewController {
            inActiveVC.willMove(toParent: nil)
            inActiveVC.view.removeFromSuperview()
            inActiveVC.removeFromParent()
        }
    }
    
    //MARK:- UITabBar Delegate
    //MARK:-
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 3 {
            if !(User.sharedInstance.isUserLoggedIn()) {
                let storyboard = UIStoryboard(name: "Account", bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginNavigationViewController")
                
                self.present(loginVC, animated: true) {
                }
                return
            }
        }
        activeViewController = viewControllers[item.tag]
    }
}

//MARK: - TabBarSegue
//MARK: -

class TabBarSegue: UIStoryboardSegue {
    override func perform() {
        if let tvc = source as? TabBarViewController {
            tvc.viewControllers.append(destination)
        }
    }
}
