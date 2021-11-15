//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

class ___VARIABLE_productName___Presenter: ___VARIABLE_productName___PresenterProtocol {
    
    weak var view: ___VARIABLE_productName___ViewProtocol?
    var interactor: ___VARIABLE_productName___InteractorProtocol?
    var router: ___VARIABLE_productName___RouterProtocol?
    
    weak var moduleOutput: ___VARIABLE_productName___ModuleOutputProtocol?
}


//MARK: - ___VARIABLE_productName___ViewOutput
//
extension ___VARIABLE_productName___Presenter: ___VARIABLE_productName___ViewOutput {
    
    func viewReadyForInteraction() {
        
        // Forward event to interactor
        interactor?.prepare()
    }
}


//MARK: - ___VARIABLE_productName___InteractorOutput
//
extension ___VARIABLE_productName___Presenter: ___VARIABLE_productName___InteractorOutput {
    
}


//MARK: - ___VARIABLE_productName___ModuleInputProtocol
//
extension ___VARIABLE_productName___Presenter: ___VARIABLE_productName___ModuleInputProtocol {
    
}
