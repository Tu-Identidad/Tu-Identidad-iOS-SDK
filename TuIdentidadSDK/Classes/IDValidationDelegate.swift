//
//  IDValidationDelegate.swift
//
//  Created by TuIdentidad on 09/12/19.
//  Copyright © 2019 Alianza Corp. All rights reserved.
//

import Foundation

public protocol IDValidationDelegate {
    func getData(data: IDValidation)
    func getINEData(data: IDValidationINE)
    func error(response: String)
}
