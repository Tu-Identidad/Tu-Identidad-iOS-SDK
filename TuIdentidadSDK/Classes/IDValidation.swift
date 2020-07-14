//
//  ValidationResponse.swift
//  TuIdentidadSDK
//
//  Created by Aaron Munguia - Tu Identidad on 11/02/20.
//

public class IDValidationResponse: Decodable {
    public var result: IDValidationData
}

public class IDValidation {
    public var validation: IDValidationData
    public var ineFront: Data
    public var ineBack: Data
    
    init(validation: IDValidationData, ineFront: Data, ineBack: Data) {
        self.validation = validation
        self.ineFront = ineFront
        self.ineBack = ineBack
    }
    
}

public class IDValidationINE {
    public var validation: IDValidationINEResponse
    public var ineFront: Data
    public var ineBack: Data
    
    init(validation: IDValidationINEResponse, ineFront: Data, ineBack: Data) {
        self.validation = validation
        self.ineFront = ineFront
        self.ineBack = ineBack
    }
}

public class IDValidationData: Decodable {
    
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

// INE Validation Response 
public class IDValidationINEResponse: Decodable {
    public var valid: Bool
    public var type: String
    public var validations: IDValidationResult
    public var front: IDSideResult
    public var back: IDSideResult
    public var data: IDINEData
    public var warnings: [IDINEWarning]
    
    var description: String {
        return ""
    }
}

public class IDValidationResult: Decodable {
    public var info: Bool!
    public var quality: Bool!
    public var curp: Bool!
    public var pattern: Bool!
}

public class IDSideResult: Decodable {
    public var focus: Bool!
    public var glare: Bool!
}

public class IDINEData: Decodable {
    public var name: String!
    public var firstLastName: String!
    public var secondLastName: String!
    public var addressLine1: String!
    public var addressLine2: String!
    public var addressLine3: String!
    public var electoralId: String!
    public var curp: String!
    public var dateOfBirth: String!
    public var sex: String!
    public var folio: String!
    public var idNumber: String!
    public var idMex: String!
    public var mz1: String!
    public var mz2: String!
    public var mz3: String!
    public var expirationDate: String!
}

public class IDINEWarning: Decodable {
    public var code: String!
    public var message: String!
}
