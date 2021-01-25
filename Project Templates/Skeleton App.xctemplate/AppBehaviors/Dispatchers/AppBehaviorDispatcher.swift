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

// Reference: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplicationDelegate_Protocol/index.html?hl=ar#//apple_ref/occ/intfm/

// This is only a tagging protocol.
// It doesn't add more functionalities yet.
public protocol ApplicationBehavior: UIApplicationDelegate { }

// Composition
//
// Initialize Dispatcher with your list of behaviors
// Dispatch interested UIApplicationDelegate events to Dispatcher
//
// @UIApplicationMain
// class AppDelegate: UIResponder, UIApplicationDelegate {
//
//     var window: UIWindow?
//     lazy var behaviorDispatcher: AppBehaviorDispatcher = { AppBehaviorDispatcher(behaviors: [RootBehavior()]) }()
//
//     func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
//         return behaviorDispatcher.application(application, willFinishLaunchingWithOptions: launchOptions)
//     }
// }
public class AppBehaviorDispatcher {

    public let behaviors: [ApplicationBehavior]

    public init(behaviors: [ApplicationBehavior]) {
        self.behaviors = behaviors
    }

    @discardableResult
    internal func apply<T, B>(_ work: (ApplicationBehavior, @escaping (T) -> Void) -> B?, completionHandler: @escaping ([T]) -> Void) -> [B] {
        
        let dispatchGroup = DispatchGroup()
        var results: [T] = []
        var returns: [B] = []

        for behavior in behaviors {
            dispatchGroup.enter()
            let returned = work(behavior, { result in
                results.append(result)
                dispatchGroup.leave()
            })
            if let returned = returned {
                returns.append(returned)
            } else { // delegate doesn't impliment method
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completionHandler(results)
        }

        return returns
    }
}
