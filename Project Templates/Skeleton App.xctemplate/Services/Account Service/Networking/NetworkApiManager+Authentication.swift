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
import PromiseKit
import Moya
import Alamofire
import AdSupport

/// Extension for NetworkApiManager implements required methods for authentication on API
///
internal extension NetworkApiManager {
    
    private struct LoginObject: Encodable {
        
        let email: String?
        let password: String?
    }
    
    struct LoginObjectResponse: Codable {
        let token: String
    }

    static func login(username: String, password: String, features: Features = [.logging]) -> Promise<LoginObjectResponse> {
        
        let provider = MoyaProvider<EverclearAuthApi>(with: features)
        let loginObject = LoginObject(email: username, password: password)
        let request = EverclearAuthApi.login(loginObject: loginObject)
        
        return self.requestData(request, with: provider)
    }
}
