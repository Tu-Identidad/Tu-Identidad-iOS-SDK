//
//  IDAddressValidationResponse.swift
//  TuIdentidadSDK
//
//  Created by Aaron Munguia on 27/07/20.
//

public class IDAddressDocumentResponse: Decodable {
    public var valid: Bool
    public var data: IDAddressDocumentData
    public var warnings: [IDErrorResponse]
}

public class IDAddressDocumentData: Decodable {
    public var name: String
    public var addressline1: String
    public var addressline2: String
    public var addressline3: String
    public var addressline4: String
    public var totalPayment: Decimal
    public var period: String
    public var serviceNumber: String
    public var paymentDeadline: String
    public var geocodeUrl: String?
    public var lat: Decimal
    public var lng: Decimal
}
