//
//  AddressViewController.swift
//  TuIdentidadSDK_Example
//
//  Created by Aaron Munguia on 27/07/20.
//  Copyright © 2020 Tu Identidad. All rights reserved.
//

import UIKit
import TuIdentidadSDK

class AddressViewController: UITableViewController, IDAddressDocumentDelegate {
    
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var addressDocumentImageView: UIImageView!
    
    // Validation
    @IBOutlet weak var validLabel: UILabel!
    @IBOutlet weak var warningsLabel: UILabel!
    
    // Address Document Data
    @IBOutlet weak var serviceNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLine1Label: UILabel!
    @IBOutlet weak var addressLine2Label: UILabel!
    @IBOutlet weak var addressLine3Label: UILabel!
    @IBOutlet weak var addressLine4Label: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var paymentDeadlineLabel: UILabel!
    @IBOutlet weak var geocodeUrlLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
    
    @IBAction func didValidateIdTouchUpInside(_ sender: Any) {
        TUID.instantiateIDAddress(delegate: self, context: self, apikey: "Your-Api-Key")
    }
    
    // MARK: - IDAddressDocumentDelegate
    
    func addressDocumentController(controller: IDAddressViewController, didFinishWithResponse response: IDAddressDocumentResponse, andImage image: UIImage) {
        print("addressDocumentController didFinishWithResponse")
        print(response.valid)
        print(response.data.name)
        addressDocumentImageView.image = image
        
        // Validation
        validLabel.text = response.valid ? "Valido" : "No Valido"
        warningsLabel.text = response.warnings.reduce("", { (warning1: String, warning2:IDErrorResponse) in
            warning1 + warning2.message
        })
        
        // Data
        serviceNumberLabel.text = response.data.serviceNumber
        nameLabel.text = response.data.name
        addressLine1Label.text = response.data.addressline1
        addressLine2Label.text = response.data.addressline2
        addressLine3Label.text = response.data.addressline3
        addressLine4Label.text = response.data.addressline4
        amountLabel.text = NSDecimalString(&response.data.totalPayment, NSLocale.current)
        periodLabel.text = response.data.period
        paymentDeadlineLabel.text = response.data.paymentDeadline
        geocodeUrlLabel.text = response.data.geocodeUrl
        latLabel.text = NSDecimalString(&response.data.lat, NSLocale.current)
        lngLabel.text = NSDecimalString(&response.data.lng, NSLocale.current)
        
        // Dissmis view controller
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addressDocumentController(controller: IDAddressViewController, didFinishWithError error: IDErrorResponse, andImage image: UIImage) {
        controller.dismiss(animated: true, completion: nil)
        print("addressDocume                  ntController didFinishWithError")
        print(error.message)
        print(error.code)
        
        addressDocumentImageView.image = image
        
        // Show alert error
        let alertController = UIAlertController(title: error.code, message: error.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
