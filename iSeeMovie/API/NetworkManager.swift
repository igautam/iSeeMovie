//
//  NetworkManager.swift
//  MyTheMovieDB
//
//  Created by Rajesh Kumar on 26/07/25.
//

import Alamofire
import Foundation

class NetworkManager {
    static let shared  = NetworkManager()
    
    private let session: Session
    private let reachabilityManager: NetworkReachabilityManager?
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        
        session = Session(configuration: configuration)
        reachabilityManager = NetworkReachabilityManager()
        
        setupReachabilityMonitoring()
    }
    
    // MARK: - Reachability
    private func setupReachabilityMonitoring() {
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                print("Network not reachable")
            case .reachable(.ethernetOrWiFi):
                print("Network reachable via WiFi")
            case .reachable(.cellular):
                print("Network reachable via Cellular")
            case .unknown:
                print("Network status unknown")
            }
        }
    }
    
    var isNetworkReachable: Bool {
        return reachabilityManager?.isReachable ?? false
    }
    
    // MARK: - Generic Request Method
    func request<T: Decodable>(
        uRLRequest: URLRequestConvertible,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard isNetworkReachable else {
            completion(.failure(.networkFailure("No internet connection")))
            return
        }
        
//        let urlString = endpoint.baseURL + endpoint.path
//        session.request(
//            urlString,
//            method: endpoint.method,
//            parameters: endpoint.parameters,
//            encoding: endpoint.encoding,
//            headers: endpoint.headers
//        )
        session.request(uRLRequest)
        .validate()
        .responseData { response in
            self.handleResponse(response, responseType: responseType, completion: completion)
        }
    }
    
    // MARK: - Async/Await Request Method
    @available(iOS 13.0, *)
    func request<T: Decodable>(
        uRLRequest: URLRequestConvertible,
        responseType: T.Type
    ) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            request(uRLRequest: uRLRequest, responseType: responseType) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    // MARK: - Response Handling
    private func handleResponse<T: Decodable>(
        _ response: AFDataResponse<Data>,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        switch response.result {
        case .success(let data):
            do {
                let decodedObject = try
                JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedObject))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        case .failure(let error):
            let networkError =
            self.mapAFErrorToNetworkError(error, response: response.response)
            completion(.failure(networkError))
        }
    }
    
    // MARK: - Error Mapping
    private func mapAFErrorToNetworkError(_ error: AFError, response: HTTPURLResponse?) -> NetworkError {
        if let statusCode = response?.statusCode {
            switch statusCode {
            case 401:
                return .unauthorized
            case 400...499:
                return .serverError(statusCode)
            case 500...599:
                return .serverError(statusCode)
            default:
                break
            }
        }
        
        switch error {
        case .invalidURL:
            return .invalidURL
        case .responseValidationFailed:
            return .serverError(response?.statusCode ?? 0)
        default:
            return .networkFailure(error.localizedDescription)
        }
    }
}

