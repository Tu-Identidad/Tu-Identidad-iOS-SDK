//
//  IDAddressViewController.swift
//  TuIdentidadSDK
//
//  Created by Aaron Munguia on 26/07/20.
//

import UIKit
import MBDocCapture
import JGProgressHUD
import Alamofire

public class IDAddressViewController: UIViewController, ImageScannerControllerDelegate {
    
    // Delegate
    public var delegate: IDAddressDocumentDelegate?
    public var apiKey: String!
    
    @IBOutlet weak var scanAddressDocumentButton: UIButton!
    private var addressDocumentImage: UIImage?
    private var hud: JGProgressHUD!
    
    public init () {
        let bundle = Bundle(for: IDAddressViewController.self)
        let bundleURL = bundle.resourceURL?.appendingPathComponent("TuIdentidadSDK.bundle")
        
        super.init(nibName: "IDAddressViewController", bundle: Bundle(url: bundleURL!))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        addressDocumentImage = nil
    }
    
    @IBAction func scanAddressDocument() {
        // Present ImageScannerController to scan document
        let vcScanner = ImageScannerController(image: nil, delegate: self)
        if #available(iOS 13.0, *) {
            vcScanner.overrideUserInterfaceStyle = .light
        }
        present(vcScanner, animated: true, completion: nil)
    }
    
    @IBAction func validateAddressDocument() {
        
        // TODO: Configure path from configuration
        let uri = "http://address-service.westus2.azurecontainer.io/address"
        
        // Create headers for authentication
        let headers: HTTPHeaders = [
            "ApiKey": self.apiKey,
            "Content-type":"multipart/form-data"
        ]
        
        if let addressDocumentImage = self.addressDocumentImage {
        
            if let addressDocumentData = addressDocumentImage.jpegData(compressionQuality: 1.0) {
                // Get selected image if image is nill then show error a message to indicate to the user that first need to scan an image before send a validation request
                
                // Show loading Hud view and get reference
                hud = self.view.showLoadingHUD()
                
                // Example of data count
                print("There were \(addressDocumentData.count) bytes")
                let bcf = ByteCountFormatter()
                bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
                bcf.countStyle = .file
                let string = bcf.string(fromByteCount: Int64(addressDocumentData.count))
                print("formatted result: \(string)")
                
                // Get a self viewController reference
                let addressDocumentController = self
                
                // Use service to validate Address Document
                // TODO: Send request to a Service Object
                let queue = DispatchQueue.main
                queue.async {
                    AF.upload(multipartFormData: { multipartFormData in
                        multipartFormData.append(addressDocumentData, withName: "imageFile", fileName: "imageFile.jpeg", mimeType: "image/jpeg")
                    }, to: uri, method: .post, headers: headers)
                    .uploadProgress{progress in
                        let p = progress.fractionCompleted
                        _ = self.view.incrementHUD(self.hud, progress: Float(p))
                    }
                    .responseDecodable{ (response: AFDataResponse<IDAddressDocumentResponse>) in
                        print("Decodable AddressDocumentResponse...")
                        switch response.result {
                        case .success(let addressDocumentResponse):
                            self.view.stopHUD(hud: self.hud, afterDelay: 0.01)
                            // Send validation result to delegate
                            self.delegate?.addressDocumentController(controller: addressDocumentController, didFinishWithResponse: addressDocumentResponse, andImage: addressDocumentImage)
                        case .failure(let error):
                            // TODO: Log error
                            // If is a parser error
                            if (200..<300).contains(response.response?.statusCode ?? 0) {
                                // Parser error
                                self.view.stopHUD(hud: self.hud, afterDelay: 0.01)
                                // didFinishWithError: Decoding Failed
                                self.delegate?.addressDocumentController(controller: addressDocumentController, didFinishWithError: IDErrorResponse(code: "E001", message: error.localizedDescription ), andImage: addressDocumentImage)
                            }
                        }
                    }
                    .responseDecodable{ (response: AFDataResponse<IDErrorResponse>) in
                        // if not response value has persed then send a error to delegate
                        print("Decodable ErrorResponse...")
                        switch(response.result) {
                        case .success(let errorResponse):
                            self.view.stopHUD(hud: self.hud, afterDelay: 0.01)
                            self.delegate?.addressDocumentController(controller: addressDocumentController, didFinishWithError: errorResponse, andImage: addressDocumentImage)
                        case .failure(let error):
                            // TODO: Log error
                            // If is a parser error or a unhandle server error
                            if !(200..<300).contains(response.response?.statusCode ?? 0) {
                                self.view.stopHUD(hud: self.hud, afterDelay: 0.01)
                                // didFinishWithError: Unknow server error
                                self.delegate?.addressDocumentController(controller: addressDocumentController, didFinishWithError: IDErrorResponse(code: "E001", message: error.localizedDescription ), andImage: addressDocumentImage)
                            }
                        }
                    }
                }
            } else {
                let title = NSLocalizedString("tuidentidadsdk.alert_title", tableName: nil, bundle: bundle(), value: "Validación de documento", comment: "")
                let message = NSLocalizedString("tuidentidadsdk.alert_message", tableName: nil, bundle: bundle(), value: "Formato invalido de imagen, favor de escanear nuevamente el documento.", comment: "")
                let titleAction = NSLocalizedString("tuidentidadsdk.alert_ok_button", tableName: nil, bundle: bundle(), value: "Aceptar", comment: "")
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: titleAction, style: .default, handler: { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
            }
            
        } else {
            let title = NSLocalizedString("tuidentidadsdk.alert_title", tableName: nil, bundle: bundle(), value: "Validación de documento", comment: "")
            let message = NSLocalizedString("tuidentidadsdk.alert_message", tableName: nil, bundle: bundle(), value: "Escanea un documento para realizar la validación.", comment: "")
            let titleAction = NSLocalizedString("tuidentidadsdk.alert_ok_button", tableName: nil, bundle: bundle(), value: "Aceptar", comment: "")
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: titleAction, style: .default, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - ImageScannerControllerDelegate
    
    public func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        // Get results image
        addressDocumentImage = results.scannedImage
        if results.doesUserPreferEnhancedImage {
            addressDocumentImage = results.enhancedImage
        }
        // Set image on scan address button
        scanAddressDocumentButton.setImage(addressDocumentImage, for: .normal)
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
    
}
