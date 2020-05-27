//
//  EpicView.swift
//  Spacing
//
//  Created by FulltrackMobile on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class EpicView: UIViewController, EpicViewProtocol {
    
    var presenter: EpicPresenterProtocol?
    
    @IBOutlet var datePickerView: UIDatePicker!
    @IBOutlet var datePickerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var datePickerDoneToolBar: UIToolbar!
    @IBOutlet var datePickerDoneToolBarHeightConstraint: NSLayoutConstraint!
    
    @IBAction func datePickerCancelToolbar(_ sender: Any) {
        print("cancel")
        dismissDatePicker()
    }
    
    @IBAction func datePickerViewDoneToolbar(_ sender: Any) {
        print("ok now is", datePickerView.date)
        dismissDatePicker()
    }
    
    func dismissDatePicker() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.datePickerView.alpha = 0
            self.datePickerDoneToolBar.alpha = 0
            self.datePickerViewHeightConstraint.constant = 0
            self.datePickerDoneToolBarHeightConstraint.constant = 0
        })
    }
    
    func render() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch))
        searchButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.purple], for: .normal)
        navigationItem.rightBarButtonItem = searchButton
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EpicWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSearch(_ sender: UIBarButtonItem! = nil) {
          UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.datePickerView.alpha = 1
            self.datePickerViewHeightConstraint.constant = 300
            self.datePickerDoneToolBar.alpha = 1
            self.datePickerDoneToolBarHeightConstraint.constant = 44
          })
      }
}
