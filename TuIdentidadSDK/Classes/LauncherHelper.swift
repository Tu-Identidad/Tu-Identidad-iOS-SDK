//
//  LauncherHelper.swift
//  IdValidation
//
//  Created by TuIdentidad on 11/7/19.
//  Copyright © 2019 TuIdentidad. All rights reserved.
//

import Foundation
import UIKit
public class LauncherHelper{
    
    init() {
        
    }
    
    public func DisplayResults(sbName: String, sbIdentifier: String, userinfo: String, context: UIViewController){
        let tmpController = ResultsViewController()
        tmpController.results = userinfo
        context.present(tmpController, animated: true, completion: nil)
        //context.navigationController?.pushViewController(tmpController, animated: true)
    }
}
