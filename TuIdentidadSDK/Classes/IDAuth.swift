//
//  IDAuth.swift
//  IdValidation
//
//  Created by TuIdentidad on 11/7/19.
//  Copyright © 2019 TuIdentidad. All rights reserved.
//

import Foundation
import HandyJSON

public class IDAuth: HandyJSON{
    var infoCheck: String?
    var qualityCheck: String?
    var patternCheck: String?
    var idAuth: String?
    var FocusFront: String?
    var GlareFront: String?
    var FocusBack: String?
    var GlareBack: String?
    var isIne: String?
    var ineType: String?
    var tipoC: tipoC?
    var tipoDE: tipoDE?
    var error: String?
    
    
    
    public class tipoC: HandyJSON{
        var name: String?
        var firstlastname: String?
        var secondlastname: String?
        var addressline1: String?
        var addressline2: String?
        var addressline3: String?
        var folio: String?
        var claveElector: String?
        var curp: String?
        var edad: String?
        var sex: String?
        var dob: String?
        
        public required init(){}
    }
    
    open class tipoDE: HandyJSON{
        var name: String?
        var firstlastname: String?
        var secondlastname: String?
        var addressline1: String?
        var addressline2: String?
        var addressline3: String?
        var claveElector: String?
        var curp: String?
        var dob: String?
        var sex: String?
        var IDMEX: String?
        var mz1: String?
        var mz2: String?
        var mz3: String?
        var ExpDate: String?
        
        public required init(){}
    }
    
    public required init(){}
}
