//
//  MainView.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MainCell"
private let headerReuseIdentifier = "MainHeaderCell"
private let collectionViewHeight:CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 600: 1200

class MainView: UICollectionViewController, MainViewProtocol {
    
    var presenter: MainPresenterProtocol?
    
    var scenes = [[Scene(title: "picture_of_the_day".localized, scene: .PICTURE_OF_THE_DAY, imageName: "nebula")], [Scene(title: "mars_rover".localized, scene: .MARS, imageName: "mars_rover")], [Scene(title: "epic".localized, scene: .EPIC, imageName: "epic")],[Scene(title: "earth".localized, scene: .EARTH, imageName: "earth")] , [Scene(title: "image_and_video_library".localized, scene: .IMAGE_AND_VIDEO_LIBRARY, imageName: "image_and_video_library")]]
    
    //var scenes = [[Scene(title: "picture_of_the_day".localized, scene: .PICTURE_OF_THE_DAY, imageName: "nebula")], [Scene(title: "mars_rover".localized, scene: .MARS, imageName: "mars_rover")]]
    
    func render() {
        title = "home".localized
        
        //navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
    }
 
    
    // MARK: View Lifecycle
    
    override func loadView() {
        super.loadView()
        let cell = UINib(nibName: "MainCell", bundle: .main)
        collectionView.register(cell, forCellWithReuseIdentifier: reuseIdentifier)
        let header = UINib(nibName: "MainHeaderCell", bundle: .main)
        collectionView.register(header, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
      
    }

    // MARK: Navigation

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return scenes.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return scenes[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainCell
        
        let scene = scenes[indexPath.section][indexPath.row]
               let shadow = NSShadow()
               shadow.shadowBlurRadius = 4
               shadow.shadowColor = UIColor.black
               shadow.shadowOffset = .zero
               let attributes:[NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 0.90, alpha: 1), .shadow: shadow, .font: UIFont.boldSystemFont(ofSize: 32)]
               let mutableText = NSMutableAttributedString(string: scene.title, attributes: attributes)
               
               cell.titleLabel.attributedText = mutableText
               
               cell.backgroundImageView.image = UIImage(named: scene.imageName)?.withRenderingMode(.alwaysOriginal)
               //cell.selectionStyle = .none
               //cell.backgroundColor = .purple
        
        cell.clipsToBounds = true
        let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft,.topRight , .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        cell.layer.mask = shape
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! MainHeaderCell
            
            return header
        default:
            return UICollectionReusableView()
        }
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("test")
        let scene = scenes[indexPath.section][indexPath.item]
        presenter?.pushTo(scene: scene)
    }

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

extension MainView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionViewHeight)
    }
}
