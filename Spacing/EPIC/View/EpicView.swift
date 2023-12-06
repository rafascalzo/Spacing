//
//  EpicView.swift
//  Spacing
//
//  Created by FulltrackMobile on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

private let epicCellReuseIdentifier = "EpicCell"

class EpicView: UIViewController, EpicViewProtocol {
    
    func didFetchImages(_ model: [EPICModel]) {
        epicModel = model
        epicCollectionView.reloadData()
    }
    
    var epicModel = [EPICModel]()
    
    func show(error: String) {
        showAlert(error)
    }
    
    func showLoading() {
        showActivityIndicator()
    }
    
    func removeLoading() {
        removeActivityIndicator()
    }
    
    var presenter: EpicPresenterProtocol?
    
    @IBOutlet var epicCollectionView: UICollectionView!
    
    @IBOutlet var datePickerView: UIDatePicker!
    @IBOutlet var datePickerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var datePickerDoneToolBar: UIToolbar!
    @IBOutlet var datePickerDoneToolBarHeightConstraint: NSLayoutConstraint!
    
    @IBAction func datePickerCancelToolbar(_ sender: Any) {
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
    
    override func loadView() {
        super.loadView()
        let nib = UINib(nibName: "EPICCell", bundle: .main)
        epicCollectionView.register(nib, forCellWithReuseIdentifier: epicCellReuseIdentifier)
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

extension EpicView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return epicModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: epicCellReuseIdentifier, for: indexPath) as! EPICCell
        
        let selected = epicModel[indexPath.item]
        
        let name = selected.imageName
        let dateFragment = selected.date.components(separatedBy: "-")
        let urlstring = "https://epic.gsfc.nasa.gov/archive/natural/\(dateFragment[0])/\(dateFragment[1])/\(dateFragment[2].components(separatedBy: " ")[0])/png/\(name).png"
        print(urlstring)
        Cache.downloadImage(urlString: urlstring) {
            cell.epicImageView.image = $0
        }
        cell.earthLatitudeLabel.text = "Latitude: \(selected.coordinates.satelliteFocusedCoordinates.latitude)"
        cell.earthLongitudeLabel.text = "Longitude: \(selected.coordinates.satelliteFocusedCoordinates.longitude)"
        cell.sunXPositionLabel.text = "X \(selected.coordinates.sunPosition.x)"
        cell.sunYPositionLabel.text = "Y \(selected.coordinates.sunPosition.y)"
        cell.sunZPositionLabel.text = "Z \(selected.coordinates.sunPosition.z)"
        cell.moonXPositionLabel.text = "X: \(selected.coordinates.moonPosition.x)"
        cell.moonYPositionLabel.text = "Y: \(selected.coordinates.moonPosition.y)"
        cell.moonZPositionLabel.text = "Z: \(selected.coordinates.moonPosition.z)"
        cell.satelliteXPositionLabel.text = "X \(selected.coordinates.satellitePosition.x)"
        cell.satelliteYPositionLabel.text = "Y \(selected.coordinates.satellitePosition.y)"
        cell.satelliteZPositionLabel.text = "Z \(selected.coordinates.satellitePosition.z)"
        return cell
    }
}

extension EpicView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EPICCell
        if let point = cell.touchLocation {
            if cell.leftArrow.bounds.contains(point) {
                let previousItem = indexPath.item - 1
                if (previousItem >= 0) {
                    let previousIndexPath = IndexPath(item: previousItem, section: 0)
                    collectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
                }
            } else if cell.rightArrow.frame.contains(point) {
                
                let nextItem = indexPath.item + 1
                if (epicModel.count > nextItem) {
                    let nextIndexPath = IndexPath(item: nextItem, section: 0)
                    collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                }
                
            } else {
                let text = epicModel[indexPath.item].caption
                performZoomInFor(startingImageView: cell.epicImageView, imageDescription: text)
            }
        }
    }
}

extension EpicView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: epicCollectionView.frame.width, height: epicCollectionView.frame.height)
    }
}
