//
//  IDViewController.swift
//
//  Created by TuIdentidad on 03/12/19.
//  Copyright © 2019 Alianza Corp. All rights reserved.
//

import UIKit
import MBDocCapture
import JGProgressHUD
import Alamofire

public class IDViewController: UIViewController, ImageScannerControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
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
    
    @IBAction func ineFrontScan(_ sender: Any) {
        scan(side: .Front)
    }
    
    @IBAction func ineBackScan(_ sender: Any) {
        scan(side: .Back)
    }
    
    /// Handle ui validate action button
    /// - Parameter sender: UIButton
    @IBAction func validateIne(_ sender: Any) {
        if ineFront != nil && ineBack != nil {
            // Compress images
            if let ineFrontCompress = ineFront.jpegData(compressionQuality: 0.5), let ineBackCompress = ineBack.jpegData(compressionQuality: 0.5){
                hud = self.view.showLoadingHUD()
                UploadHelper.sendINE(ineFront: ineFrontCompress, ineBack: ineBackCompress, api: self.apikey, m: self.method, p: validateOptions)
                    .uploadProgress{ [self] progress in
                        let mhud = self.view.incrementHUD(hud, progress: Float(progress.fractionCompleted))
                        if mhud != nil{
                           hud = mhud
                        }
                    }.responseDecodable(of: IDValidationINEResponse.self){ [self] response in
                        self.view.stopHUD(hud: hud, afterDelay: 0.01)
                        switch response.result {
                        case .success:
                            delegate?.getINEData(data: IDValidationINE(validation: response.value!, ineFront: ineFrontCompress, ineBack: ineBackCompress))
                        case .failure(_):
                            var responseData = "{ code: 'server_error', message: 'Connection error, validators server is not available please try again later.' }"
                            if let data = response.data {
                                if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                                    responseData = stringData
                                }
                            }
                            delegate?.error(response: responseData)
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
            } else {
                NSLog("TuIdentidadSDK: error when compressing images")
                delegate?.error(response: "error when compressing images")
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            // TODO: Localized string
            var message = "Captura el reverso de tu identificación."
            if ineFront == nil {
                // TODO: Localized string
                message = "Captura el frente de tu identificación."
            }
            // Show Alert Controller
            // TODO: Localized string
            let alertController = UIAlertController(title: "Captura de imagen", message: message, preferredStyle: .alert)
            // TODO: Localized string
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default))
            self.present(alertController, animated: true, completion: nil)
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
        self.currentSide = side
        let actionsheet = UIAlertController()
        actionsheet.addAction(UIAlertAction(title: "Capturar Imagen", style: .default,handler:{
            action in
            let vcScanner = ImageScannerController(image: nil, delegate: self)
            if #available(iOS 13.0, *) {
                vcScanner.overrideUserInterfaceStyle = .light
            }
            self.present(vcScanner, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Adjuntar Imagen", style: .default,handler:{
            action in
            let imageController = UIImagePickerController()
            imageController.delegate = self
            imageController.sourceType = UIImagePickerController.SourceType.photoLibrary
            imageController.allowsEditing = true
            self.present(imageController , animated: true)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancelar", style: .destructive,handler:{
            action in
        }))
        present(actionsheet, animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.dismiss(animated: true, completion:nil)
        let vcScanner = ImageScannerController(image: image, delegate: self)
        self.present(vcScanner, animated: true, completion: nil)
    }
}

    
    
