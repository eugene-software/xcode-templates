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


// Uncomment if needed
//MARK: ___VARIABLE_productName:identifier___ViewModelDelegate - Callback delegate

//protocol ___VARIABLE_productName:identifier___ViewModelDelegate: class {
//
//
//}


//MARK: ViewModel - Main Interface

protocol ___VARIABLE_productName:identifier___ViewModelInterface {
    
//    Uncomment if needed
//    weak var delegate: ___VARIABLE_productName:identifier___ViewModelDelegate?  { get set }
}


//MARK: ViewController - Main Interface

protocol ___VARIABLE_productName:identifier___ViewControllerInterface {
    
    var viewModel: ___VARIABLE_productName:identifier___ViewModelInterface!  { get set }
    func configureWith(_ model: ___VARIABLE_productName:identifier___ViewModelInterface)
}