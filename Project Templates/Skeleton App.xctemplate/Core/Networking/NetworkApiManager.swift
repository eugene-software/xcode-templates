//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file is generated by custom SKELETON Xcode template.
//

import Foundation
import Moya
import PromiseKit


public final class NetworkApiManager {
    
    private static let kBaseUrlUserDefaultsKey: String = "kBaseUrlUserDefaultsKey"
    
    /// Features options to use in requests
    ///
    public struct Features: OptionSet {
        
        public let rawValue: UInt64
        
        public init(rawValue: UInt64) {
            self.rawValue = rawValue
        }
        
        public static let logging = Features(rawValue: 1 << 0)
        public static let stubbing = Features(rawValue: 1 << 1)
    }
    
    /// A custom decoder for API
    ///
    static let customDecoder: JSONDecoder = CustomJSONDecoder()
    
    /// A custom encoder for API
    ///
    static let customEncoder: JSONEncoder = CustomJSONEncoder()
    
    /// Base URL is retrieved from main bundle
    ///
    static var baseURL: URL {
        
        set {
            UserDefaults.standard.set(newValue.absoluteString, forKey: NetworkApiManager.kBaseUrlUserDefaultsKey)
            UserDefaults.standard.synchronize()
        }
        
        get {
            let serverURLString = Bundle.main.infoDictionary?["SERVER_URL"] as! String
            let base = UserDefaults.standard.string(forKey: Self.kBaseUrlUserDefaultsKey) ?? serverURLString
            return URL(string: base)!
        }
    }
    
    /// Base URL is retrieved from main bundle
    ///
    static var apiURL: URL {
        
        let apiURLString = Bundle.main.infoDictionary?["API_URL"] as! String
        return URL(string: baseURL.absoluteString + apiURLString)!
    }
}


// MARK: - Request methods

public extension NetworkApiManager {

    static func requestVoid<T: TargetType>(_ target: T, with provider: MoyaProvider<T>) -> Promise<Void> {

        return firstly {
            provider.request(target)
        }.then { response -> Promise<Void> in
            return response.filterSuccessfulStatusCodes().asVoid()
        }.recover { error in
            throw handleMoyaError(error)
        }
    }

    static func requestData<T: TargetType, D: Decodable>(_ target: T, with provider: MoyaProvider<T>) -> Promise<D> {

        return firstly {
            provider.request(target)
        }.then { response -> Promise<Response> in
            return response.filterSuccessfulStatusCodes()
        }.then { response -> Promise<D> in
            return response.promiseMap(D.self, using: customDecoder)
        }.recover { error -> Promise<D> in
            throw handleMoyaError(error)
        }
    }
}


// MARK: - Helpers

private extension NetworkApiManager {
    
    /// Errors handling
    ///
    static func handleMoyaError(_ error: Error) -> NetworkApiError {
        
        logger.error(error)
        let ecError = NetworkApiError(error)
        (error as? MoyaError)?.logToCrashlytics(with: ecError)
        return ecError
    }
}

