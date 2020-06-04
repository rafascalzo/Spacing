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
private let headerCellIdentifier = "HeaderCellIdentifier"
private let roversCellIdentifier = "RoversCellIdentifier"

class MarsRoverView: UIViewController , MarsRoverViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var presenter: MarsRoverPresenterProtocol?
    
   
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var datePickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var datePickerToolbar: UIToolbar!
    @IBOutlet var datePickerToolbarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var menuView: UIView!
    @IBOutlet var roversCollectionView: UICollectionView!
    @IBOutlet var camerasCollectionView: UICollectionView!
    @IBOutlet var dateTextField: UITextField!
    
    @IBOutlet var searchButton: UIButton!
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        hideMenu()
        guard let date = selectedDate else { return }
        guard let rover = selectedRover else { return }
        presenter?.fetchByEarthDate(rover: rover, camera: selectedCamera, date: date, page: 1)
    }
    
    @IBOutlet var menuWidthConstraint: NSLayoutConstraint!
    
    
    var photos = [RoverPhotosObject]()
    var cameras = [RoverCamera]()
    var rovers = [RoverName]()
    var selectedCamera: RoverCamera?
    var selectedDate: Date?
    var selectedRover: RoverName!
    
    // MARK: View Life Cycle
    override func loadView() {
        super.loadView()
        let nib = UINib(nibName: "MarsRoverCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        let headerNib = UINib(nibName: "MarsRoverHeaderCell", bundle: .main)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellIdentifier)
        
        
        let cameraNib = UINib(nibName: "MarsCameraCell", bundle: .main)
        camerasCollectionView.register(cameraNib, forCellWithReuseIdentifier: cameraReuseIdentifier)
        
        let roversNib = UINib(nibName: "MarsRoversCell", bundle: .main)
        roversCollectionView.register(roversNib, forCellWithReuseIdentifier: roversCellIdentifier)
        
        let calendarTap = UITapGestureRecognizer(target: self, action: #selector(handleCalendarTapped))
        calendarTap.cancelsTouchesInView = false
        dateTextField.addGestureRecognizer(calendarTap)
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchTapped))
        searchButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.graffiti], for: .normal)
        navigationItem.rightBarButtonItem = searchButton
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MarsRoverWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
        
        RoverName.allCases.forEach {
            rovers.append($0)
        }
        selectedRover = rovers.first
        roversCollectionView.reloadData()
        
        RoverCamera.allCases.forEach {
            cameras.append($0)
        }
        selectedDate = Date()
        camerasCollectionView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    func render() {
        title = "Mars Rover"
        collectionView.backgroundColor = .white
        //presenter?.fetchByEarthDate(rover: .curiosity, camera: .fhaz, date: nil, page: 1)
        title = Date.stringValue(from: Date(), pattern: .dayMonthYear).replacingOccurrences(of: "-", with: "/")
        presenter?.fetchByMartianSol(rover: .opportunity, camera: nil, sol: 1000, page: 1)
    }
    
    func showLoading() {
        showActivityIndicator()
    }
    
    func removeLoading() {
        removeActivityIndicator()
    }
    
    func didFetch(roverPhotos: MarsRoverPhotos) {
        if let photos = roverPhotos.photos {
            self.photos = photos
            collectionView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        showAlert(message)
    }
    
    
    func showMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.menuView.alpha = 1
            self.menuWidthConstraint.constant = self.view.frame.width
        })
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.menuView.alpha = 0
            self.menuWidthConstraint.constant = 0
        })
    }
    
    func removeDatePicker() {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.datePicker.alpha = 0
            self.datePickerToolbar.alpha = 0
            self.datePickerHeightConstraint.constant = 0
            self.datePickerToolbarHeightConstraint.constant = 0
        }) { finished in
            self.searchButton.isHidden = false
        }
       
    }
    
    func showDatePicker() {
        searchButton.isHidden = true
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
          self.datePicker.alpha = 1
          self.datePickerHeightConstraint.constant = 200
          self.datePickerToolbar.alpha = 1
          self.datePickerToolbarHeightConstraint.constant = 44
        })
    }

    // MARK: - IBACTIONS
    
    @IBAction func handleOkDatePickerToolbar(_ sender: Any) {
        selectedDate = datePicker.date
        dateTextField.text = Date.stringValue(from: datePicker.date, pattern: .dayMonthYear).replacingOccurrences(of: "-", with: "/")
        removeDatePicker()
    }
    
    @IBAction func handleCancelDatePickerToolbar(_ sender: Any) {
        removeDatePicker()
    }
    
    @objc func handleCalendarTapped(_ sender: Any) {
        showDatePicker()
    }
    
    @objc func handleDismissTapped(_ sender: UITapGestureRecognizer) {
        removeDatePicker()
        hideMenu()
    }
    
    @objc func handleSearchTapped(_ sender: UIBarButtonItem) {
           showMenu()
       }

    // MARK: - Navigation
 
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return photos.count
        } else if collectionView == self.roversCollectionView {
            return rovers.count
        } else {
            return cameras.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MarsRoverCell
            
                let selected = photos[indexPath.item]
            cell.earthDateLabel.text = "Earth date \(selected.earthDate)"
            cell.cameraDescriptionLabel.text = selected.camera.fullName
            cell.solLabel.text = "Sol \(selected.sol)"
                let urlString = selected.imageSource.replacingOccurrences(of: "http", with: "https")
                
                Cache.downloadImage(urlString: urlString) {
                    cell.cardImageView.image = $0
                }
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleBookmarkTapped(_:)))
                cell.bookmarkImageView.addGestureRecognizer(tap)
                
            
                return cell
        } else if collectionView == self.roversCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: roversCellIdentifier, for: indexPath) as! MarsRoversCell
            cell.roverNameLabel.text = rovers[indexPath.item].name.capitalized
            let mask = CAShapeLayer()
            let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 8, height: 8))
            mask.path = path.cgPath
            cell.layer.masksToBounds = true
            cell.layer.mask = mask
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cameraReuseIdentifier, for: indexPath) as! MarsCameraCell
            
            cell.cameraNameLabel.text = cameras[indexPath.item].value.lowercased().capitalized
            let mask = CAShapeLayer()
            let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 8, height: 8))
            mask.path = path.cgPath
            cell.layer.masksToBounds = true
            cell.layer.mask = mask
            return cell
        }
    }
    
    @objc func handleBookmarkTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view?.superview?.superview as? MarsRoverCell {
            guard let indexPath = collectionView.indexPath(for: cell) else { return }
            guard let image = cell.cardImageView.image else { return }
            let selected = photos[indexPath.item]
            let filename = getDocumentsDirectory().appendingPathComponent("\(selected.id)")
            
            guard let data = image.pngData() else { return }
            do {
                NSLog("\(filename)")
                try data.write(to: filename)
                print("success")
            } catch {
                NSLog(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! MarsRoverCell
            performZoomInFor(startingImageView: cell.cardImageView, imageDescription: "Cell Freeza e Goku")
        } else if collectionView == self.roversCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! MarsRoversCell
            if cell.roverNameLabel.textColor == .graffiti {
                cell.roverNameLabel.textColor = .dirtyAir
                selectedRover = .curiosity
            } else {
                cell.roverNameLabel.textColor = .graffiti
                selectedRover = rovers[indexPath.item]
            }
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! MarsCameraCell
            if selectedCamera != nil {
                cell.cameraNameLabel.textColor = .dirtyAir
                selectedCamera = nil
            } else {
                cell.cameraNameLabel.textColor = .graffiti
                selectedCamera = cameras[indexPath.item]
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            
        } else if collectionView == self.roversCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? MarsRoversCell {
                cell.roverNameLabel.textColor = .dirtyAir
            }
        } else {
            if let cell = collectionView.cellForItem(at: indexPath) as? MarsCameraCell {
                cell.cameraNameLabel.textColor = .dirtyAir
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellIdentifier, for: indexPath) as! MarsRoverHeaderCell
        guard let info = photos.first?.rover else { return view }
        view.landingDateLabel.text = "Landing date: \(info.landingDate)"
        view.launchDateLabel.text = "Launch date: \(info.launchDate)"
        view.maxDateLabel.text = "Max date: \(info.maxDate)"
        view.maxSolLabel.text = "Max sol: \(info.maxSol)"
        view.stateLabel.text = "Status: \(info.status)"
        view.roverNameLabel.text = "Rover name: \(info.name)"
        view.totalPhotosLabel.text = "Total photos: \(info.totalPhotos)"
        return view
    }
}

extension MarsRoverView {
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension MarsRoverView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionView {
            return CGSize(width: view.frame.width, height: 450)
        } else if collectionView == self.roversCollectionView {
            return CGSize(width: ((view.frame.width * 0.92) - 20) / 3, height: 35)
        } else {
            return CGSize(width: 100, height: 35)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if collectionView == self.collectionView {
            return CGSize(width: view.frame.width, height: 100)
        } else {
            return .zero
        }
    }
}
