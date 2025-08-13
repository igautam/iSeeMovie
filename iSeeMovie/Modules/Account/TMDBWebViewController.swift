//
//  TMDBWebViewController.swift
//  iSeeMovies
//
//  Created by Tais on 7/9/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit
import WebKit

class TMDBWebViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    var token: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = URL(string: "https://www.themoviedb.org/authenticate/\(token)") {
            let urlRequest = URLRequest(url: url)
             webView.load(urlRequest)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
