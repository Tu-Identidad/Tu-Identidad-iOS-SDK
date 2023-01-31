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
    public var curpData: IDCURPData
    public var nominalListData: IDNominalListData
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
    public var face: Bool!
    public var nominalListCheck: Bool!
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

public class IDCURPData: Decodable {
    public var curp: String!
    public var names: String!
    public var lastname: String!
    public var secondlastname: String!
    public var sex: String!
    public var dateofbirth: String!
    public var nationality: String!
    public var entity: String!
    public var crip: String!
    public var statusCurp: String!
    public var folio: String!
    public var probationaryDocument: String!
    public var foreignerNumber: String!
    public var registrationEntity: String!
    public var tome: String!
    public var municipalityRegistryKey: String!
    public var yearOfregistry: String!
    public var registryEntityKey: String!
    public var page: String!
    public var actNumber: String!
    public var book: String!
 }

public class IDNominalListData: Decodable {
    public var canVote: Bool!
    public var type: String!
    public var electorCode: String!
    public var cicNumber: String!
    public var issueNumber: String!
    public var issueYear: String!
    public var registrationYear: String!
    public var ocrNumber: String!
    public var expDate: String!
}

public class IDINEWarning: Decodable {
    public var code: String!
    public var message: String!
}
