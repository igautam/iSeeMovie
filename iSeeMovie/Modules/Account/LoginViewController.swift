//
//  LoginViewController.swift
//  iSeeMovies
//
//  Created by Tais on 7/9/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let networkService =  NetworkService()
//showTMDBWebView
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func dismissViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func loginUsingTMDB(_ sender: UIButton) {
        Task {
            do {
                let tokenResponse = try await networkService.createRequestToken()
                if tokenResponse.success {
                    DispatchQueue.main.async { [self] in
                        self.performSegue(withIdentifier: "showTMDBWebView", sender: tokenResponse.requestToken)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func loginAsGuest(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC: TMDBWebViewController = segue.destination as? TMDBWebViewController {
            if let token = sender as? String {
                destinationVC.token = token
            }
        }
    }

}
