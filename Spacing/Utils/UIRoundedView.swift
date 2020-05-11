//
//  UIRoundedView.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

@IBDesignable
class UIRoundedView: UIView {
    
    @IBInspectable
       var borderRadius: CGFloat {
           get {
               return layer.cornerRadius
           }
           set {
               layer.cornerRadius = newValue
           }
       }
       
       @IBInspectable
       var borderColor: UIColor? {
           get {
               guard let color = layer.borderColor else { return nil }
               return UIColor(cgColor: color)
           }
           set {
               guard let color = newValue else { layer.borderColor = nil; return }
               layer.borderColor = color.cgColor
           }
       }
       
       @IBInspectable
       var borderWidth: CGFloat {
           get {
               return layer.borderWidth
           }
           set {
               layer.borderWidth = newValue
           }
       }
       
       @IBInspectable
       var shadowColor: UIColor? {
           get {
               guard let color = layer.shadowColor else { return nil }
               return UIColor(cgColor: color)
           }
           set {
               layer.shadowColor = newValue?.cgColor
           }
       }
       
       @IBInspectable
       var shadowRadius: CGFloat {
           get {
               return layer.shadowRadius
           }
           set {
               layer.shadowRadius = newValue
           }
       }
       
       @IBInspectable
       var shadowOffset: CGSize {
           get {
               return layer.shadowOffset
           }
           set {
               layer.shadowOffset = newValue
           }
       }
       
       @IBInspectable
       var shadowPath: CGPath? {
           get {
               return layer.shadowPath
           }
           set {
               layer.shadowPath = newValue
           }
       }
       
       @IBInspectable
       var maskToBounds: Bool {
           get {
               return layer.masksToBounds
           }
           set {
               layer.masksToBounds = newValue
           }
       }
       
       @IBInspectable
       var shadowOpacity:Float {
           get {
               return layer.shadowOpacity
           }
           set {
               layer.shadowOpacity = newValue
           }
       }
       
       public override func awakeFromNib() {
           super.awakeFromNib()
           configureRoundedImageView()
       }
       
       public override func prepareForInterfaceBuilder() {
           super.prepareForInterfaceBuilder()
           configureRoundedImageView()
       }
       
       func configureRoundedImageView() {
           layer.cornerRadius = borderRadius
           layer.borderColor = borderColor?.cgColor
           layer.borderWidth = borderWidth
           
           layer.shadowColor = shadowColor?.cgColor
           layer.shadowRadius = shadowRadius
           layer.shadowOffset = shadowOffset
           layer.shadowPath = shadowPath
           layer.masksToBounds = maskToBounds
           layer.shadowOpacity = shadowOpacity
       }
}
