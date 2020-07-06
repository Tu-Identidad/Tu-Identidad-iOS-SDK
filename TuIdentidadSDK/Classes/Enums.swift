//
//  Enum.swift
//  IdAuth
//
//  Created by TuIdentidad on 11/8/19.
//  Copyright © 2019 TuIdentidad. All rights reserved.
//

import Foundation

public enum IneSide{
    case Front
    case Back
    case None
}

public enum Methods{
    case IDVAL
    case ONLYOCR
    case INE
}

public enum ProgressType{
    case INE_U_P
    case INE_D_P
    case INE_RESPONSE
    case INE_RESPONSE_ERROR
    case THUMB_U_P
    case THUMB_D_P
    case THUMB_RESPONSE
}
