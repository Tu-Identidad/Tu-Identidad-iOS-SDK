//
//  IDAddressDocumentDelegate.swift
//  TuIdentidadSDK
//
//  Created by Aaron Munguia on 27/07/20.
//

import Foundation

public protocol IDAddressDocumentDelegate {
    
    func addressDocumentController(controller: IDAddressViewController, didFinishWithResponse response: IDAddressDocumentResponse, andImage image: UIImage);
    
    func addressDocumentController(controller: IDAddressViewController, didFinishWithError error: IDErrorResponse, andImage image: UIImage);
}
