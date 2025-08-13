//
//  APIManager.swift
//  iSeeMovies
//
//  Created by Tais on 7/4/18.
//  Copyright © 2018 Tais. All rights reserved.
//

//import Foundation
//import Alamofire
//import AlamofireNetworkActivityIndicator
//
//class APIManager {
//    static var sharedInstance = APIManager()
//    fileprivate let networkManager = Alamofire.SessionManager()
//    fileprivate let queue = OperationQueue()
//    fileprivate let group = DispatchGroup()
//    fileprivate let reachability = Alamofire.NetworkReachabilityManager()
//    var isReachable: Bool {
//        return reachability?.isReachable != false
//    }
//    
//    init() {
//        queue.maxConcurrentOperationCount = 1
//        networkManager.startRequestsImmediately = false
//        NetworkActivityIndicatorManager.shared.isEnabled = true
//        reachability?.startListening()
//    }
//}
//
//
//extension APIManager {
//    func request(_ URLRequest: URLRequestConvertible) -> DataRequest {
//        let request = networkManager.request(URLRequest).responseData { _ in
//            (self.group).leave()
//        }
//        
//        queue.addOperation {
//            self.group.enter()
//            request.resume()
//            let _ = self.group.wait(timeout: DispatchTime.distantFuture)
//        }
//        
//        return request
//    }
//    
//    class func request(_ URLRequest: URLRequestConvertible) -> DataRequest {
//        return APIManager.sharedInstance.request(try! URLRequest.asURLRequest())
//    }
//}
