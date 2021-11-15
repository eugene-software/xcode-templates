//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

class ___VARIABLE_productName___ViewController: UIViewController {

    var output: ___VARIABLE_productName___ViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Notify presenter layer with ready state.
        self.output?.viewReadyForInteraction()

        // Do any additional setup after loading the view.
    }
}


//MARK: - ___VARIABLE_productName___ViewProtocol
//
extension ___VARIABLE_productName___ViewController: ___VARIABLE_productName___ViewProtocol {
    
}
