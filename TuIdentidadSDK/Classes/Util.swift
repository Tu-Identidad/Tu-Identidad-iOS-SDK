//
//  Util.swift
//  TuIdentidad
//
//  Created by Desarrollo on 8/15/18.
//  Copyright © 2018 Desarrollo. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

public class Util{
    
    public static func saveImageFile(filename: String, image: UIImage) -> String?{
        let fileManager = FileManager.default
        
        let imagepath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(filename)
        let data = image.pngData()
        
        if fileManager.createFile(atPath: imagepath, contents: data, attributes: nil){
//            print("save doc \(filename) succesfull")
            return imagepath
        }
        
//        print("save doc \(filename) error")
        
        return nil
    }
    
    public static func saveImageFile(filename: String, data: Data) -> String?{
        let fileManager = FileManager.default
        
        let imagepath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(filename)
       
        
        if fileManager.createFile(atPath: imagepath, contents: data, attributes: nil){
            return imagepath
        }
        
        return nil
    }
    
    public static func getImage(filename: String) -> UIImage?{
        return UIImage(data: self.getImageData(filename: filename))
    }
    
    public static func getImageData(filename: String) -> Data{
        let fileManager = FileManager.default
        let imagepath = filename
        
        if fileManager.fileExists(atPath: imagepath){
//            print("file exists at \(imagepath)")
        }else{
//            print("there is no file for \(imagepath)")
        }
        let url = URL.init(fileURLWithPath: imagepath)
        let data = try! Data.init(contentsOf: url, options: [.mappedIfSafe, .uncached])
        
        return data
    }
}

