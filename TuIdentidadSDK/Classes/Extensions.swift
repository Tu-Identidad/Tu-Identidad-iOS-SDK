//
//  Extensions.swift
//  IdValidation
//
//  Created by TuIdentidad on 11/5/19.
//  Copyright © 2019 TuIdentidad. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD

public extension UIView{

    func showSimpleHUD(title textLabel: String, details detailtext: String) -> JGProgressHUD{
        let hud = JGProgressHUD(style: .light)
        hud.vibrancyEnabled = true
        hud.textLabel.text = textLabel
        hud.detailTextLabel.text = detailtext
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
        hud.show(in: self)
        
        return hud
    }
    
    func stopHUD(hud: JGProgressHUD, afterDelay: TimeInterval){
        hud.dismiss(afterDelay: afterDelay, animated: true)
    }
    
    func showLoadingHUD() -> JGProgressHUD{
        let hud = JGProgressHUD(style: .dark)
        hud.vibrancyEnabled = true
        
        if arc4random_uniform(2) == 0 {
           hud.indicatorView = JGProgressHUDPieIndicatorView()
        }
        else {
           hud.indicatorView = JGProgressHUDRingIndicatorView()
        }
        
        hud.detailTextLabel.text = "0% Completado"
        hud.textLabel.text = "Subiendo archivos"
        hud.show(in: self)
        
        return hud
    }
    
    func incrementHUD(_ hud: JGProgressHUD, progress: Float) -> JGProgressHUD?{
        var mHud: JGProgressHUD! = nil
        let percentage = ((progress * 100) / 1).rounded()
        let p = percentage / 100.0
        hud.progress = p
        hud.detailTextLabel.text = "\(percentage.rounded())% Completado"
        
        if percentage >= 100 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                UIView.animate(withDuration: 0.5, animations: {
                    hud.textLabel.text = "Success"
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                })
                
                hud.dismiss(afterDelay: 1.0, animated: true)
            }
            
             mHud = self.showSimpleHUD(title: "Validando Documento", details: "Espere un momento")
        }
        
        return mHud
    }
    
    func loadViewFromNib() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "IDViewController", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
}

extension UIViewController {

    func bundle() -> Bundle {
        let frameworkBundle = Bundle(for: type(of: self))
        let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("TuIdentidadSDK.bundle")
        
        if let bundle = Bundle(url: bundleURL!) {
            return bundle
        } else {
            return Bundle(for: type(of: self))
        }
    }
}
