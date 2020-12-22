//
//  IDViewController.swift
//
//  Created by TuIdentidad on 03/12/19.
//  Copyright © 2019 Alianza Corp. All rights reserved.
//

import UIKit
import MBDocCapture
import JGProgressHUD

public class IDViewController: UIViewController, ImageScannerControllerDelegate {
    
    var delegate: IDValidationDelegate?
    
    @IBOutlet weak var imgIneFront: UIButton!
    @IBOutlet weak var imgIneBack: UIButton!
    
    private var currentSide: IneSide = .None
    private var ineFront:UIImage!
    private var ineBack:UIImage!
    private var ineFrontCaptured = false
    private var ineBackCaptured = false
    private var hud: JGProgressHUD!
   
    public var method: Methods!
    public var apikey: String!
    public var showResults: Bool! = true
    public var validateOptions: IDValidateOptions!
   
    public init () {
        let bundle = Bundle(for: IDViewController.self)
        let bundleURL = bundle.resourceURL?.appendingPathComponent("TuIdentidadSDK.bundle")
        
        super.init(nibName: "IDViewController", bundle: Bundle(url: bundleURL!))
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

    public override func viewDidLoad() {
        super.viewDidLoad()
   
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
           // Fallback on earlier versions
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(onUserAction(_:)), name: Notification.Name(rawValue:   UploadHelper.u_r), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onUserAction(_:)), name: Notification.Name(rawValue: UploadHelper.t_r), object: nil)
    }
   
    public override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
   
    @objc func onUserAction(_ notification: Notification){
       
        let userinfo = notification.userInfo
        if(!(userinfo?.isEmpty)!){
            if let type = userinfo!["type"] as? ProgressType{
                
                switch type {
                case .INE_U_P:
                    let p = (userinfo!["progress"] as? Double)!
                    let mhud = self.view.incrementHUD(hud, progress: Float(p))
                    if mhud != nil{
                       hud = mhud
                    }
                    break
                case .INE_D_P:
                    self.view.stopHUD(hud: hud, afterDelay: 0.01)
                    break
                case .INE_RESPONSE:
                    self.view.stopHUD(hud: hud, afterDelay: 0.01)
                    if let response = userinfo!["response"] as? IDValidation {
//                        if showResults {
//                            LauncherHelper().DisplayResults(sbName: "Main", sbIdentifier: "resultsID", userinfo: response.validation.description, context: self)
//                        }
                        delegate?.getData(data: response)
                    } else if let response = userinfo!["response"] as? IDValidationINE {
//                        if showResults {
//                            LauncherHelper().DisplayResults(sbName: "Main", sbIdentifier: "resultsID", userinfo: response.validation.description, context: self)
//                        }
                        delegate?.getINEData(data: response)
                        
                    }
                    self.dismiss(animated: true, completion: nil)
                    break
                case .INE_RESPONSE_ERROR:
                    self.view.stopHUD(hud: hud, afterDelay: 0.01)
                    if let response = userinfo!["response"] as? String {
                        delegate?.error(response: response)
                    }
                    self.dismiss(animated: true, completion: nil)
                case .THUMB_U_P:
        
                    break
                case .THUMB_D_P:
                   
                    break
                case .THUMB_RESPONSE:
                   
                    break
                }
            }
        }
    }
    
    
    @IBAction func ineFrontScan(_ sender: Any) {
        scan(side: .Front)
    }
    @IBAction func ineBackScan(_ sender: Any) {
        scan(side: .Back)
    }
    @IBAction func validateIne(_ sender: Any) {
        if ineFront != nil && ineBack != nil{
            
            if let ineFrontCompress = ineFront.jpegData(compressionQuality: 0.5), let ineBackCompress = ineBack.jpegData(compressionQuality: 0.5){
                UploadHelper.sendINE(ineFront: ineFrontCompress, ineBack: ineBackCompress, api: self.apikey, m: self.method)
            }else{
                print("Error en la compresión") 
            }
            hud = self.view.showLoadingHUD()
           
        }else{
            if !ineFrontCaptured{
                print("No has capturado el ineFront")
            } else if !ineBackCaptured{
                print("No has capturado el ineBack")
            }
        }
    }
    
    
    public func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        switch(self.currentSide){
           case .Front:
            self.ineFront = results.scannedImage
            self.imgIneFront.setImage(results.scannedImage, for: .normal)
               break;
           case .Back:
            self.ineBack = results.scannedImage
            self.imgIneBack.setImage(results.scannedImage, for: .normal)
               break;
           default:
               break;
       }
        
        scanner.dismiss(animated: true, completion: nil)
    }
       
    public func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithPage1Results page1Results: ImageScannerResults, andPage2Results page2Results: ImageScannerResults) {
        scanner.dismiss(animated: true, completion: nil)
    }
       
    public func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        scanner.dismiss(animated: true, completion: nil)
    }
       
    public func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        scanner.dismiss(animated: true, completion: nil)
    }
    
    public func scan(side: IneSide){
        let vcScanner = ImageScannerController(image: nil, delegate: self)
        if #available(iOS 13.0, *) {
            vcScanner.overrideUserInterfaceStyle = .light
        }
        present(vcScanner, animated: true, completion: nil)
        self.currentSide = side
    }
}
