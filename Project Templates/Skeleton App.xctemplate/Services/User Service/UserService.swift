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

extension UserServiceInjected {
    public var userService: UserServiceProtocol { return Services.user }
}

class UserService: UserServiceProtocol {
    
    func getMyUser() -> Promise<User> {
        
        return firstly {
            NetworkApiManager.getUser()
        }.then { user -> Promise<User> in

            return AppDatabaseImporter.importRemoteList([user]).map { _ in
                let user: User? = AppDatabaseExporter.exportRemoteSingle(predicate: NSPredicate(value: user.id))
                return user
            }.compactMap { $0 }
        }
    }
}


// MARK: - Private Methods
//
private extension UserService {
    

}
