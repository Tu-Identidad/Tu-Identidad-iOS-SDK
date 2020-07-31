//
//  IDAddressValidationResponse.swift
//  TuIdentidadSDK
//
//  Created by Aaron Munguia on 27/07/20.
//

public class IDAddressDocumentResponse: Decodable {
    public var validity: Bool
    public var data: IDAddressDocumentData
}

public class IDAddressDocumentData: Decodable {
    public var name: String
    public var addressline1: String
    public var addressline2: String
    public var addressline3: String
    public var addressline4: String
    
    public var totalPayment: Decimal
}
