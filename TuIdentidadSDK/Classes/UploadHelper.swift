//
//  UploadeHelper.swift
//  IdValidation
//
//  Created by TuIdentidad on 11/6/19.
//  Copyright © 2019 TuIdentidad. All rights reserved.
//
import Foundation
import UIKit
import Alamofire

public class UploadHelper{
    
    public static let u_r = "UPLOAD_REQUEST"
    public static let t_r = "THUMBNAIL_REQUEST"
    
    public static func sendINE(ineFront: UIImage, ineBack: UIImage, api: String, m: Methods){
        var uri = Paths.baseURL!
        let ineFPath = Util.saveImageFile(filename: "ineFront.png", image: ineFront)!
        let ineBPath = Util.saveImageFile(filename: "ineBack.png", image: ineBack)!
        
        let ineFData = Util.getImageData(filename: ineFPath)
        let ineBData = Util.getImageData(filename: ineBPath)
        
        switch m {
        case .IDVAL:
            uri += Paths.prefix.auth!
            break
        case .ONLYOCR:
            uri += Paths.prefix.ocr!
            break
            
        }
        
        let headers: HTTPHeaders = [
            "ApiKey": api,
            "Content-type":"multipart/form-data"
        ]
        
        let queue = DispatchQueue.main
        queue.async {
            AF.upload(multipartFormData: {
                multipartFormData in
                multipartFormData.append(ineFData, withName: "FrontFile", fileName: "FrontFile", mimeType: "application/octet-stream")
                multipartFormData.append(ineBData, withName: "BackFile", fileName: "BackFile", mimeType: "application/octet-stream")
            }, to: uri, method: .post, headers: headers)
            .uploadProgress{ progress in
                let p = progress.fractionCompleted
                NotificationCenter.default.post(name: Notification.Name(self.u_r), object: self, userInfo: [
                    "type": ProgressType.INE_U_P,
                    "progress": p
                ])
//                print("Upload Progress \(progress.fractionCompleted)")
            }.downloadProgress{ progress in
                let p = progress.fractionCompleted
                NotificationCenter.default.post(name: Notification.Name(self.u_r), object: self, userInfo: [
                    "type": ProgressType.INE_D_P,
                    "progress": p
                ])
//                print("Downloand Progress \(progress.fractionCompleted)")
            }.responseDecodable { (response: AFDataResponse<IDValidation>) in
                if let validation = response.value { NotificationCenter.default.post(name: Notification.Name(self.u_r), object: self, userInfo: [
                        "type": ProgressType.INE_RESPONSE,
                        "response": validation
                    ])
                }
            }.responseDecodable { (response: AFDataResponse<IDValidationResponse>) in
                if let validation = response.value?.result { NotificationCenter.default.post(name: Notification.Name(self.u_r), object: self, userInfo: [
                        "type": ProgressType.INE_RESPONSE,
                        "response": validation
                    ])
                }
            }.response { response in
                NotificationCenter.default.post(name: Notification.Name(self.u_r), object: self, userInfo: [
                    "type": ProgressType.INE_RESPONSE_ERROR,
                    "response": response.value as Any
                ])
            }
        }
    }
    
    public static func getThumbnail(ineFront: UIImage){
        let uri = Paths.mobileBaseURL! + Paths.prefix.analize!
        let ineFPath = Util.saveImageFile(filename: "ineFront.png", image: ineFront)!
        let ineFData = Util.getImageData(filename: ineFPath)
        
        let headers: HTTPHeaders = [
            "Content-type":"multipart/form-data"
        ]
        
        let queue = DispatchQueue.main
        queue.async {
            AF.upload(multipartFormData: {
                multipartFormData in
                multipartFormData.append(ineFData, withName: "document", fileName: "document", mimeType: "application/octet-stream")
            }, to: uri, method: .post, headers: headers)
            .uploadProgress{ progress in
                let p = progress.fractionCompleted
                NotificationCenter.default.post(name: Notification.Name(self.t_r), object: self, userInfo: [
                    "type": ProgressType.THUMB_U_P,
                    "progress": p
                ])
                print("Upload Progress \(progress.fractionCompleted)")
            }.downloadProgress{ progress in
                let p = progress.fractionCompleted
                NotificationCenter.default.post(name: Notification.Name(self.t_r), object: self, userInfo: [
                    "type": ProgressType.THUMB_D_P,
                    "progress": p
                ])
                print("Upload Progress \(progress.fractionCompleted)")
            }.response{ response in
                if let mData = response.data{
                    let stringData = String(data: mData, encoding: String.Encoding.utf8)!
                    NotificationCenter.default.post(name: Notification.Name(self.t_r), object: self, userInfo: [
                        "type": ProgressType.THUMB_RESPONSE,
                        "response": stringData
                    ])
                }
            }
        }
    }
}
