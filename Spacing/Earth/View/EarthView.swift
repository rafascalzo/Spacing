//
//  EarthView.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class EarthView: UIViewController, EarthViewProtocol {
    
    @IBOutlet var earthImageView: UIImageView!
    @IBOutlet var earthDescriptionLabel: UILabel!
    
    var presenter: EarthPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EarthWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    func didFetchImage(_ base64String: String) {
         
         if let data = base64String.data(using: .utf8) {
             if let dataz = Data(base64Encoded: data, options: Data.Base64DecodingOptions(rawValue: 0))  {
                            if let i = UIImage(data: dataz) {
                             print("lkkkkk")
                             earthImageView.image = i
                            }
                        }
             
         }
     }
    
    func render() {
        
        
    }
    
    func showLoading() {
        showActivityIndicator()
    }
    
    func removeLoading() {
        removeActivityIndicator()
    }
    
    func showError(_ message: String) {
        showAlert(message)
    }
}
