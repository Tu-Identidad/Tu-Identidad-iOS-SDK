//
//  TUID.swift
//  IdValidation
//
//  Created by TuIdentidad on 11/4/19.
//  Copyright © 2019 TuIdentidad. All rights reserved.
//

import Foundation
import UIKit

public class TUID: NSObject {
    
    private override init(){
           super.init()
    }
    
    
    open class func instantiateIDAuth(delegate: IDAuthDelegate, context: UIViewController, apikey: String, method: Methods, showResults: Bool){
        let tmpController = IDViewController()
        tmpController.delegate = delegate
        tmpController.apikey = apikey
        tmpController.method = method
        tmpController.showResults = showResults
        context.present(tmpController, animated: true, completion: nil)
    }
}
