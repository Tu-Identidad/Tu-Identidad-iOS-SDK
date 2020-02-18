//
//  ViewController.swift
//  TuIdentidadSDK
//
//  Created by Tu Identidad on 02/11/2020.
//  Copyright (c) 2020 Aaron Munguia. All rights reserved.
//

import UIKit
import TuIdentidadSDK

class ViewController: UITableViewController, IDAuthDelegate {
        
    @IBOutlet weak var validateIdButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstLastnameLabel: UILabel!
    @IBOutlet weak var secondLastnameLabel: UILabel!
    
    @IBOutlet weak var addressLine1Label: UILabel!
    @IBOutlet weak var addressLine2Label: UILabel!
    @IBOutlet weak var addressLine3Label: UILabel!
    
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var yearsOldLabel: UILabel!
    
    @IBOutlet weak var INEKeyLabel: UILabel!
    @IBOutlet weak var folioLabel: UILabel!
    @IBOutlet weak var registryNumberLabel: UILabel!
    @IBOutlet weak var mz1Label: UILabel!
    @IBOutlet weak var mz2Label: UILabel!
    @IBOutlet weak var mz3Label: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didValidateIdTouchUpInside(_ sender: Any) {
        TUID.instantiateIDAuth(delegate: self, context: self, apikey: "YourAPIKey", method: .IDVAL, showResults: false)
    }
    
    // MARK - IDAuthDelegate
    func getData(data: IDValidation) {
        print(data)
        if let ocrINE = data.tipoDE {
            nameLabel.text = ocrINE.name
            firstLastnameLabel.text = ocrINE.firstlastname
            secondLastnameLabel.text = ocrINE.secondlastname
            
            addressLine1Label.text = ocrINE.addressline1
            addressLine2Label.text = ocrINE.addressline2
            addressLine3Label.text = ocrINE.addressline3
            
            sexLabel.text = ocrINE.sex
            birthdayLabel.text = ocrINE.dob
            yearsOldLabel.text = "No present"
            
            INEKeyLabel.text = ocrINE.claveElector
            folioLabel.text = "No present"
            registryNumberLabel.text = "No present"
            mz1Label.text = ocrINE.mz1
            mz2Label.text = ocrINE.mz2
            mz3Label.text = ocrINE.mz3
            expirationDateLabel.text = ocrINE.expDate
        }
        
        if let ocrINE = data.tipoC {
            nameLabel.text = ocrINE.name
            firstLastnameLabel.text = ocrINE.firstlastname
            secondLastnameLabel.text = ocrINE.secondlastname
            
            addressLine1Label.text = ocrINE.addressline1
            addressLine2Label.text = ocrINE.addressline2
            addressLine3Label.text = ocrINE.addressline3
            
            sexLabel.text = ocrINE.sex
            birthdayLabel.text = ocrINE.dob
            yearsOldLabel.text = ocrINE.edad
            
            INEKeyLabel.text = ocrINE.claveElector
            folioLabel.text = ocrINE.folio
            registryNumberLabel.text = ocrINE.idNumber
            mz1Label.text = "No present"
            mz2Label.text = "No present"
            mz3Label.text = "No present"
            expirationDateLabel.text = "No present"
        }
        
    }
    
}
