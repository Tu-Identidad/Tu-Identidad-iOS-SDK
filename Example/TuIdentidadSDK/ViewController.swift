//
//  ViewController.swift
//  TuIdentidadSDK
//
//  Created by Tu Identidad on 02/11/2020.
//  Copyright (c) 2020 Aaron Munguia. All rights reserved.
//

import UIKit
import TuIdentidadSDK

class ViewController: UITableViewController, IDValidationDelegate {
        
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
    @IBOutlet weak var curpLabel: UILabel!
    
    @IBOutlet weak var INEKeyLabel: UILabel!
    @IBOutlet weak var folioLabel: UILabel!
    @IBOutlet weak var idmexLabel: UILabel!
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
        TUID.instantiateIDAuth(delegate: self, context: self, apikey: "Your-Api-Key", method: .INE, showResults: false, validateOptions: IDValidateOptions(checkInfo: true, checkQuality: true, checkPatterns: true, checkCurp: true))
    }
    
    // MARK - IDAuthDelegate
    func getData(data: IDValidation) {
        debugPrint(data.ineFront)
        debugPrint(data.ineBack)
        debugPrint(data)
        if let ocrINE = data.validation.tipoDE {
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
        
        if let ocrINE = data.validation.tipoC {
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
    
    func getINEData(data: IDValidationINE) {
        debugPrint(data)
        nameLabel.text = data.validation.data.name
        firstLastnameLabel.text = data.validation.data.firstLastName
        secondLastnameLabel.text = data.validation.data.secondLastName
        
        addressLine1Label.text = data.validation.data.addressLine1
        addressLine2Label.text = data.validation.data.addressLine2
        addressLine3Label.text = data.validation.data.addressLine3
        
        sexLabel.text = data.validation.data.sex
        birthdayLabel.text = data.validation.data.dateOfBirth
        yearsOldLabel.text = "deprecated"
        curpLabel.text = data.validation.data.curp
        
        INEKeyLabel.text = data.validation.data.electoralId
        folioLabel.text = data.validation.data.folio
        idmexLabel.text = data.validation.data.idMex
        registryNumberLabel.text = data.validation.data.idNumber
        mz1Label.text = data.validation.data.mz1
        mz2Label.text = data.validation.data.mz2
        mz3Label.text = data.validation.data.mz3
        expirationDateLabel.text = data.validation.data.expirationDate
    }
    
    func error(response: String) {
        print(response)
    }
}
