//
//  Paths.swift
//  IdValidation
//
//  Created by TuIdentidad on 11/6/19.
//  Copyright © 2019 TuIdentidad. All rights reserved.
//

import Foundation

public class Paths : NSObject{
//    public static let baseURL:String? = "https://web-prod01.tuidentidad.com/"
    public static let baseURL:String? = "http://dev.tuidentidad.com/"
    public static let mobileBaseURL:String? = "https://mobile-prod01.tuidentidad.com/"

    
    public class prefix{
        public static let auth:String? = "api/business/idval"
        public static let ocr:String? = "api/business/onlyocr"
        public static let analize:String? = "api/business/analizedocument"
        public static let ine:String? = "api/business/ine"
    }
}
