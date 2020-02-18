//
//  ResultsController.swift
//  IdValidation
//
//  Created by TuIdentidad on 11/7/19.
//  Copyright © 2019 TuIdentidad. All rights reserved.
//
import Foundation
import UIKit
import Eureka

public class ResultsViewController: FormViewController{
    
    public var results: String?
    
    public init () {
        super.init(nibName: "ResultsViewController", bundle: Bundle(for: ResultsViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
            tableView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: CGFloat(255), green: CGFloat(255), blue: CGFloat(255), alpha: CGFloat(1)))
        } else {
            tableView.backgroundColor = UIColor(displayP3Red: CGFloat(255), green: CGFloat(255), blue: CGFloat(255), alpha: CGFloat(1))
          // Fallback on earlier versions
        }
        
        if let idauth = IDAuth.deserialize(from: results){
            animateScroll = true
            form +++ Section()
            form +++ Section("ID")
            <<< TextRow(){ row in
                row.title = "IDTYPE"
                row.value = idauth.isIne
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            <<< TextRow(){ row in
                row.title = "SUBTYPE"
                row.value = idauth.ineType
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            <<< TextRow(){ row in
                row.title = "ELECTOR CODE"
                row.value = idauth.tipoC != nil ? idauth.tipoC?.claveElector : idauth.tipoDE?.claveElector
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            <<< TextRow(){ row in
                row.title = "EXP DATE"
                row.value = idauth.tipoC != nil ? "" : idauth.tipoDE?.ExpDate
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            form +++ Section("Citizen")
            <<< TextRow(){ row in
                row.title = "NAME"
                let n1:String? = idauth.tipoC != nil ? idauth.tipoC?.name! : idauth.tipoDE?.name!
                let n2:String? = idauth.tipoC != nil ? idauth.tipoC?.firstlastname! : idauth.tipoDE?.firstlastname!
                let n3:String? = idauth.tipoC != nil ? idauth.tipoC?.secondlastname! : idauth.tipoDE?.secondlastname!
                row.value = "\(n1!) \(n2!) \(n3!)"
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            <<< TextRow(){ row in
                row.title = "ADDRESSLINE 1"
                let ad1:String? = idauth.tipoC != nil ? idauth.tipoC?.addressline1! : idauth.tipoDE?.addressline1!
                row.value = "\(ad1!)"
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            <<< TextRow(){ row in
                let ad2:String? = idauth.tipoC != nil ? idauth.tipoC?.addressline2! : idauth.tipoDE?.addressline2!
                row.title = "ADDRESSLINE 2"
                row.value = "\(ad2!)"
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            <<< TextRow(){ row in
                let ad3:String? = idauth.tipoC != nil ? idauth.tipoC?.addressline3! : idauth.tipoDE?.addressline3!
                row.title = "ADDRESSLINE 3"
                row.value = "\(ad3!)"
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            <<< TextRow(){ row in
                row.title = "CURP"
                row.value = idauth.tipoC != nil ? idauth.tipoC?.curp : idauth.tipoDE?.curp
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            <<< TextRow(){ row in
                row.title = "DATE OF BIRTH"
                row.value = idauth.tipoC != nil ? idauth.tipoC?.dob : idauth.tipoDE?.dob
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            <<< TextRow(){ row in
                row.title = "SEX"
                row.value = idauth.tipoC != nil ? idauth.tipoC?.sex : idauth.tipoDE?.sex
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            form +++ Section("Authenticity")
            <<< TextRow(){ row in
                row.title = "IDVAL"
                row.value = idauth.idAuth
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            <<< TextRow(){ row in
                row.title = "QUALITY"
                row.value = idauth.qualityCheck
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            <<< TextRow(){ row in
                row.title = "INFO"
                row.value = idauth.infoCheck
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
            <<< TextRow(){ row in
                row.title = "PATTERNS"
                row.value = idauth.patternCheck
                row.disabled = true
            }.cellSetup{ cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 12.0)
            }
        }else{
            tableView.isHidden = true
            self.view.sendSubviewToBack(tableView)
        }
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
