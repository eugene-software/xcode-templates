//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file is generated by custom MVVM Xcode template.
//

import Foundation
import Combine

//MARK: Router - Main Interface

protocol ___VARIABLE_productName:identifier___RouterProtocol: AnyObject {
    
}


//MARK: Module - Inputs and Outputs Interface

protocol ___VARIABLE_productName:identifier___ModuleInputProtocol: AnyObject {
    
}

protocol ___VARIABLE_productName:identifier___ModuleOutputProtocol: AnyObject {
    
}


//MARK: ViewModel - Main Interface

protocol ___VARIABLE_productName:identifier___ViewModelInterface {
    
    func viewReady()
}


//MARK: ViewController - Main Interface

protocol ___VARIABLE_productName:identifier___ViewControllerInterface {
    
    var viewModel: ___VARIABLE_productName:identifier___ViewModelInterface!  { get set }
    func bind()
}
