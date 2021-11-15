//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

class ___VARIABLE_productName___ModuleConfigurator {
    
    static func configurateModule(view: ___VARIABLE_productName___ViewProtocol?, delegate: ___VARIABLE_productName___ModuleOutputProtocol?)
        -> (view: UIViewController?, module: ___VARIABLE_productName___ModuleInputProtocol?) {
        
        assert(view != nil, "Please, provide view instance.")
        
        let interactor = ___VARIABLE_productName___Interactor()
        let presenter = ___VARIABLE_productName___Presenter()
        let router = ___VARIABLE_productName___Router()
        
        view?.output = presenter
        
        interactor.output = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        presenter.moduleOutput = delegate
        
        router.viewController = view as? UIViewController
        
        return (router.viewController, presenter)
    }
}

