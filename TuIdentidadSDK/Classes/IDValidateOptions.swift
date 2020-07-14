//
//  IDValidateOptions.swift
//  Alamofire
//
//  Created by Aaron Munguia on 23/06/20.
//

public class IDValidateOptions {
    public var checkInfo: Bool;
    public var checkQuality: Bool;
    public var checkPatterns: Bool;
    public var checkCurp: Bool;
    
    public init(checkInfo: Bool, checkQuality: Bool, checkPatterns: Bool, checkCurp: Bool) {
        self.checkInfo = checkInfo;
        self.checkQuality = checkQuality;
        self.checkPatterns = checkPatterns;
        self.checkCurp = checkCurp;
    }
}
