//
//  APIPromise.swift
//  iSeeMovies
//
//  Created by Tais on 7/7/18.
//  Copyright © 2018 Tais. All rights reserved.
//

//import PromiseKit
//import Alamofire
////import AlamofireObjectMapper
//import ObjectMapper
//
//extension Alamofire.URLRequestConvertible
//{
//    func requestObject<T:Mappable>() -> Promise<T> {
//        return Promise { seal in
//            APIManager.request(try! self.asURLRequest()).responseObject{ (response: DataResponse<T>) in
//                if let error = response.apiError {
//                    seal.reject(error)
//                } else if let value = response.apiValue {
//                    seal.fulfill(value)
//                }
//            }
//        }
//    }
//    
//    func requestJSON() -> Promise<Any> {
//        return Promise { seal in
//            APIManager.request(try! self.asURLRequest()).responseJSON{ response in
//                if let error = response.apiError {
//                    seal.reject(error)
//                }else if let value = response.apiValue {
//                    seal.fulfill(value)
//                }
//            }
//        }
//    }
//    
//    func requestCountryArray() -> Promise<[CountryModel]> {
//        return Promise { seal in
//            APIManager.request(try! self.asURLRequest()).responseData { response in
//                if let error = response.apiError {
//                    seal.reject(error)
//                } else if let value = response.apiValue {
//                    do {
//                        let json: Any! =  try JSONSerialization.jsonObject(with: value, options: JSONSerialization.ReadingOptions.mutableContainers)
//                        if let countryResponse = Mapper<CountryModel>().mapArray(JSONObject: json) {
//                            seal.fulfill(countryResponse)
//                        }
//                    } catch {
//                        seal.reject(NSError(domain: "", code: -1, userInfo: nil))
//                    }
//                }
//            }
//        }
//    }
//}
