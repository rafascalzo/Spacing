//
//  UIViewController.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class Loading: NSObject {
    
    var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        view.alpha = 0
        return view
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let style = UIActivityIndicatorView.Style.whiteLarge
        let ai = UIActivityIndicatorView(style: style)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.hidesWhenStopped = true
        return ai
    }()
    
    func showActivityIndicator() {
        if let window = UIApplication.shared.keyWindow {
            
            window.addSubview(blackView)
            blackView.frame = window.frame
            window.addSubview(activityIndicator)
            activityIndicator.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
            activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
            activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
            startActivityAnimation()
        }
    }
    
    func removeActivityIndicatorView() {
        stopActivityAnimation()
        blackView.removeFromSuperview()
        activityIndicator.removeFromSuperview()
    }
    
    fileprivate func startActivityAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            
        }, completion: { (_) in
            self.activityIndicator.startAnimating()
        })
    }
    
    fileprivate func stopActivityAnimation() {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
        }) { (_) in
            self.activityIndicator.stopAnimating()
            self.blackView.removeFromSuperview()
            self.activityIndicator.removeFromSuperview()
        }
    }
    
    override init() {super.init()}
}


extension UIViewController {
    
    static var loading = Loading()
    
    func showActivityIndicator() {
        UIViewController.loading.showActivityIndicator()
    }
    
    func removeActivityIndicator() {
        UIViewController.loading.removeActivityIndicatorView()
    }
    
    func showAlert(_ message: String) {
        let ac = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: nil))
        present(ac, animated: true)
    }
}
