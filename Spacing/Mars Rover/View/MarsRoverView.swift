//
//  MarsRoverView.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MarsRoverCell"

class MarsRoverView: UICollectionViewController , MarsRoverViewProtocol {
    var presenter: MarsRoverPresenterProtocol?
    var photos = [RoverPhotosObject]()
    
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
    
    override func loadView() {
        super.loadView()
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let nib = UINib(nibName: "MarsRoverCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MarsRoverWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Navigation
 
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MarsRoverCell
    
        let selected = photos[indexPath.item]
        
        let urlString = selected.imageSource.replacingOccurrences(of: "http", with: "https")
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                cell.cardImageView.image = image
            } else {
                cell.cardImageView.image = UIImage(named: "mars_rover")
            }
        }
    
        return cell
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
    
}

extension MarsRoverView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
}
