//
//  MarsRoverView.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MarsRoverCell"
private let cameraReuseIdentifier = "MarsRoverCameraReuseIdentifier"

class MarsRoverView: UIViewController , MarsRoverViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var presenter: MarsRoverPresenterProtocol?
    
    @IBOutlet var calendarImageView: UIImageView!
    @IBOutlet var searchImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var datePickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var datePickerToolbar: UIToolbar!
    @IBOutlet var datePickerToolbarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var camerasCollectionView: UICollectionView!
    
    var photos = [RoverPhotosObject]()
    var cameras = [RoverCamera]()
    var selectedCamera: RoverCamera?
    var selectedDate: Date?
    // MARK: View Life Cycle
    override func loadView() {
        super.loadView()
        let nib = UINib(nibName: "MarsRoverCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        let cameraNib = UINib(nibName: "MarsCameraCell", bundle: .main)
        camerasCollectionView.register(cameraNib, forCellWithReuseIdentifier: cameraReuseIdentifier)
        
        let calendarTap = UITapGestureRecognizer(target: self, action: #selector(handleCalendarTapped))
        calendarTap.cancelsTouchesInView = false
        calendarImageView.addGestureRecognizer(calendarTap)
        let searchTap = UITapGestureRecognizer(target: self, action: #selector(handleSearchTapped))
        searchTap.cancelsTouchesInView = false
        searchImageView.addGestureRecognizer(searchTap)
        
        let dismiss = UITapGestureRecognizer(target: self, action: #selector(handleDismissTapped))
        dismiss.cancelsTouchesInView = false
        view.addGestureRecognizer(dismiss)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MarsRoverWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
        
        RoverCamera.allCases.forEach {
            cameras.append($0)
        }
        selectedCamera = RoverCamera.allCases.first
        selectedDate = Date()
        camerasCollectionView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    func render() {
    
        title = "Mars Rover"
        collectionView.backgroundColor = .white
        //presenter?.fetchByEarthDate(rover: .curiosity, camera: .fhaz, date: nil, page: 1)
        presenter?.fetchByMartianSol(rover: .opportunity, camera: nil, sol: 1000, page: 1)
    }
    
    func showLoading() {
        showActivityIndicator()
    }
    
    func removeLoading() {
        removeActivityIndicator()
    }
    
    func didFetch(roverPhotos: MarsRoverPhotos) {
        print(roverPhotos)
        if let photos = roverPhotos.photos {
            self.photos = photos
            collectionView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        showAlert(message)
    }
    
    @objc func handleCalendarTapped(_ sender: Any) {
        showDatePicker()
    }
    
    @objc func handleDismissTapped(_ sender: UITapGestureRecognizer) {
        removeDatePicker()
    }
    
    func removeDatePicker() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.datePicker.alpha = 0
            self.datePickerToolbar.alpha = 0
            self.datePickerHeightConstraint.constant = 0
            self.datePickerToolbarHeightConstraint.constant = 0
        })
    }
    
    func showDatePicker() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
          self.datePicker.alpha = 1
          self.datePickerHeightConstraint.constant = 200
          self.datePickerToolbar.alpha = 1
          self.datePickerToolbarHeightConstraint.constant = 44
        })
    }
    
    @objc func handleSearchTapped(_ sender: Any) {
        guard let date = selectedDate else { return }
        guard let camera = selectedCamera else { return }
        presenter?.fetchByEarthDate(rover: .curiosity, camera: camera, date: date, page: 1)
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func handleOkDatePickerToolbar(_ sender: Any) {
        selectedDate = datePicker.date
        removeDatePicker()
    }
    
    @IBAction func handleCancelDatePickerToolbar(_ sender: Any) {
        removeDatePicker()
    }

    // MARK: - Navigation
 
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return photos.count
        } else {
            return cameras.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MarsRoverCell
            
                let selected = photos[indexPath.item]
                
                let urlString = selected.imageSource.replacingOccurrences(of: "http", with: "https")
                
                if let img = Cache.fetchImage(named: urlString) {
                    cell.cardImageView.image = img
                } else {
                    Cache.downloadImage(urlString: urlString) {
                        cell.cardImageView.image = $0
                    }
                }
                return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cameraReuseIdentifier, for: indexPath) as! MarsCameraCell
            
            cell.cameraNameLabel.text = cameras[indexPath.item].value
            let mask = CAShapeLayer()
            let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 17, height: 17))
            mask.path = path.cgPath
            cell.layer.masksToBounds = true
            cell.layer.mask = mask
            return cell
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! MarsRoverCell
            performZoomInFor(startingImageView: cell.cardImageView, imageDescription: "Cell Freeza e Goku")
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! MarsCameraCell
            cell.backgroundColor = .purple
            cell.cameraNameLabel.textColor = .white
            selectedCamera = cameras[indexPath.item]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            
        } else {
            if let cell = collectionView.cellForItem(at: indexPath) as? MarsCameraCell {
                cell.backgroundColor = .white
                cell.cameraNameLabel.textColor = .black
            }
        }
    }
}

extension MarsRoverView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: view.frame.width, height: 300)
        } else {
            return CGSize(width: 100, height: 50)
        }
    }
}
