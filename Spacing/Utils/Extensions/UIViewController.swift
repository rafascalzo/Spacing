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

// Fullscreen zoom
extension UIViewController {
    
    static var startingZoomFrame: CGRect?
    static var blackBackgroundView: UIView?
    
    func performZoomInFor(startingImageView: UIImageView, imageDescription: String?) {
        
        UIViewController.startingZoomFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        
        let zoomingImageView = UIImageView(frame: UIViewController.startingZoomFrame!)
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.contentMode = .scaleAspectFit
        zoomingImageView.layer.masksToBounds = true
        if let keyWindow = UIApplication.shared.keyWindow {
            
            UIViewController.blackBackgroundView = UIView(frame: keyWindow.frame)
            UIViewController.blackBackgroundView?.backgroundColor = .black
            UIViewController.blackBackgroundView?.alpha = 1
            UIViewController.blackBackgroundView?.isUserInteractionEnabled = true
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(handleZoomOut))
            gesture.cancelsTouchesInView = false
            keyWindow.addGestureRecognizer(gesture)
            
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
            zoomingImageView.addGestureRecognizer(pinch)
            let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
            zoomingImageView.addGestureRecognizer(pan)
            
            zoomingImageView.image = startingImageView.image
            
            
            let label = UILabel()
            label.text = imageDescription
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 25)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            keyWindow.addSubview(UIViewController.blackBackgroundView!)
            keyWindow.addSubview(label)
            keyWindow.addSubview(zoomingImageView)
            
            label.topAnchor.constraint(equalTo: keyWindow.topAnchor, constant: 50).isActive = true
            label.centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor).isActive = true
            label.widthAnchor.constraint(equalToConstant: 300).isActive  = true
            label.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                zoomingImageView.frame = CGRect(x: keyWindow.frame.minX, y: keyWindow.center.y, width: keyWindow.frame.width, height: keyWindow.frame.width)
                UIViewController.blackBackgroundView?.alpha = 1
                zoomingImageView.center = self.view.center
            })
        }
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        // 2
        guard let gestureView = sender.view else {
          return
        }

        gestureView.center = CGPoint(
          x: gestureView.center.x + translation.x,
          y: gestureView.center.y + translation.y
        )
        // 3
        sender.setTranslation(.zero, in: view)
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        guard sender.view != nil else { return }
               NSLog("pinch test")
               if sender.state == .began || sender.state == .changed {
                
               
                   sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
                   sender.scale = 1.0
                   
               }
    }
    
    @objc func handleZoomOut(_ gesture: UITapGestureRecognizer) {
        if let blackBackgroundView = gesture.view {
            print(blackBackgroundView.subviews.count)
            for subview in blackBackgroundView.subviews {
                if subview is UIImageView {
                    if let zoomOutImageView = subview as? UIImageView {
                        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                            zoomOutImageView.frame = UIViewController.startingZoomFrame!
                            zoomOutImageView.alpha = 0
                            UIViewController.blackBackgroundView?.alpha = 0
                        }) { (completed: Bool) in
                            zoomOutImageView.removeFromSuperview()
                        }
                    }
                }
                if subview is UILabel {
                    if let labelName = subview as? UILabel {
                        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                            labelName.alpha = 0
                        }) { (completed: Bool) in
                            labelName.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
}
