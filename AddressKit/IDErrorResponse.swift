//
//  IDErrorResponse.swift
//  TuIdentidadSDK
//
//  Created by Aaron Munguia on 27/07/20.
//

import Alamofire

public class IDErrorResponse: Decodable {
    public var code: String
    public var message: String
    
    init(code: String, message: String) {
        self.code = code
        self.message = message
    }
}
