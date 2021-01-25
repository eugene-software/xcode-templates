//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file is generated by custom SKELETON Xcode template.
//

import UIKit

// Opening a URL-Specified Resource
public extension AppBehaviorDispatcher {

    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        var result = false
        
        for behavior in behaviors {
            if behavior.application?(app, open: url, options: options) ?? false {
                result = true
            }
        }
        
        return result
    }
}
