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

final class AppDatabaseBehavior: NSObject, ApplicationBehavior {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        setupDatabase(application)
        return true
    }

    private func setupDatabase(_ application: UIApplication) {
        try? AppDatabase.openDatabase(in: application)
    }
}