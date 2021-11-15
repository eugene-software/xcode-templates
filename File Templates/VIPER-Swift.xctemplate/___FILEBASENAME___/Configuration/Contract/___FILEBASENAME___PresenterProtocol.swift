//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

protocol ___VARIABLE_productName___PresenterProtocol: ___VARIABLE_productName___ViewOutput, ___VARIABLE_productName___InteractorOutput, ___VARIABLE_productName___ModuleInputProtocol {
    
    var view: ___VARIABLE_productName___ViewProtocol? { get set }
    var interactor: ___VARIABLE_productName___InteractorProtocol? { get set }
    var router: ___VARIABLE_productName___RouterProtocol? { get set }
    
    var moduleOutput: ___VARIABLE_productName___ModuleOutputProtocol? { get set }
}
