//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file is generated by custom MVVM Xcode template.
//

import UIKit

class ___VARIABLE_productName:identifier___ModuleConfigurator {
    
    static func configurateModule(view: ReferralLinkViewProtocol?, delegate: ___VARIABLE_productName:identifier___ModuleOutputProtocol?)
    -> (view: UIViewController?, module: ___VARIABLE_productName:identifier___ModuleInputProtocol?) {
        
        assert(view != nil, "Please, provide view instance.")
        
        let viewModel = ___VARIABLE_productName:identifier___ViewModel()
        let router = ___VARIABLE_productName:identifier___Router()
        
        view?.viewModel = viewModel
        viewModel.router = router
        
        router.viewController = view as? UIViewController
        
        return (router.viewController, viewModel)
    }
    
    static func createModule(delegate: ___VARIABLE_productName:identifier___ModuleOutputProtocol?)
    -> (view: UIViewController?, module: ___VARIABLE_productName:identifier___ModuleInputProtocol?) {
        
        let vc = //Create a view controller from storyboard
        return configurateModule(view: vc, delegate: delegate)
    }
}
