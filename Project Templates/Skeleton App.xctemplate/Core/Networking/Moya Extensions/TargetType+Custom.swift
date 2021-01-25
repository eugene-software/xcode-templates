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

extension TargetType {
    
    static var bundle: Bundle {
        return Bundle(for: DummyClassForFindingFrameworkBundle.self)
    }
    
    var caseName: String {
        return Mirror(reflecting: self).children.first?.label ?? String(describing: self)
    }
    
    var sampleData: Data {
        
        let fileName = String(describing: self).components(separatedBy: "(").first
        
        if let url = Self.bundle.url(forResource: fileName, withExtension: "json") {
            return (try? Data(contentsOf: url)) ?? Data()
        } else {
            return Data()
        }
    }
}

extension TargetType {
    
    var headers: [String : String]? {
        
        let defaultHeaders: [String: Any] = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]

        switch self {
        default: return defaultHeaders as? [String: String]
        }
    }
}



fileprivate class DummyClassForFindingFrameworkBundle {}
