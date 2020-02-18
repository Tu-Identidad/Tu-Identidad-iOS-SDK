//
//  ValidationResponse.swift
//  TuIdentidadSDK
//
//  Created by Aaron Munguia - Tu Identidad on 11/02/20.
//

public class IDValidationResponse: Decodable {
    public var result: IDValidation
}

public class IDValidation: Decodable {
    
    public var infoCheck: String
    public var qualityCheck: String
    public var patternCheck: String

    public var idAuth: String

    // Quality
    public var focusFront: String
    public var focusBack: String

    public var glareFront: String
    public var glareBack: String

    public var isIne: String
    public var ineType: String

    public var tipoC: TypeC?
    public var tipoDE: TypeDE?

    public var error: String

    var description: String {
        return "IDValidation: { infoCheck:, error: \(error) }"
    }
}

public class TypeC: Decodable {
    public var name: String
    public var firstlastname: String
    public var secondlastname: String
    
    public var addressline1: String
    public var addressline2: String
    public var addressline3: String
    
    public var claveElector: String
    public var curp: String
    
    public var dob: String
    public var sex: String
    public var edad: String
    
    public var folio: String
    public var idNumber: String
    
}

public class TypeDE: Decodable {
    
    public var name: String
    public var firstlastname: String
    public var secondlastname: String
    
    public var addressline1: String
    public var addressline2: String
    public var addressline3: String
    
    public var claveElector: String
    public var curp: String
    
    public var dob: String
    public var sex: String
    
    public var idmex: String
    
    public var mz1: String
    public var mz2: String
    public var mz3: String
    
    public var expDate: String
}
