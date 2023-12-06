//
//  PictureOfTheDayView.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

enum MediaType: String {
    case image = "image", video = "video"
}

import UIKit
import WebKit

class PictureOfTheDayView: UIViewController, PictureOfTheDayViewProtocol {
    
    @IBOutlet var imageOfTheDayContainerView: UIView!
    @IBOutlet var imageOfTheDayTitleLabel: UILabel!
    @IBOutlet var imageOfTheDayImageView: UIImageView!
    @IBOutlet var imageOfTheDayDescriptionContainerTextField: UIView!
    @IBOutlet var imageOfTheDayDescriptionTextView: UITextView!
    @IBOutlet var imageOfTheDayVideoView: WKWebView!
    
    var presenter: PictureOfTheDayPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PictureOfTheDayWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    func render() {
        view.backgroundColor = .blue
        imageOfTheDayDescriptionContainerTextField.alpha = 0.3
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageTapped(_:)))
        tap.cancelsTouchesInView = false
        imageOfTheDayImageView.addGestureRecognizer(tap)
    }
    
    @objc func handlePinchZoom(sender: UIPinchGestureRecognizer) {
        
        guard sender.view != nil else { return }
        
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1.0
        }
    }
    
    @objc func handleImageTapped(_ sender: Any) {
        performZoomInFor(startingImageView: imageOfTheDayImageView, imageDescription: "Picture of the Day")
    }
    
    func showError(_ message: String) {
        showAlert(message)
    }
    
    func load(_ content: PictureOfTheDay) {
        print(content)
        imageOfTheDayTitleLabel.text = content.title
        imageOfTheDayDescriptionTextView.text = content.explanation
        if content.mediaType == MediaType.image.rawValue {
            configure(content: content,for: .image)
        } else {
            configure(content: content, for: .video)
        }
    }
    
    func showLoading() {
        showActivityIndicator()
    }
    
    func removeLoading() {
        removeActivityIndicator()
    }
    
    func configure(content: PictureOfTheDay,for mediaType: MediaType) {
        switch mediaType {
        case .video:
            imageOfTheDayImageView.isHidden = true
            imageOfTheDayVideoView.isHidden = false
            
            imageOfTheDayVideoView = WKWebView(frame: imageOfTheDayVideoView.superview!.bounds, configuration: WKWebViewConfiguration())
            imageOfTheDayVideoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            imageOfTheDayVideoView.load(URLRequest(url: URL(string: content.urlString)!))
        default:
            imageOfTheDayVideoView.isHidden = true
            imageOfTheDayImageView.isHidden = false
            if let url = URL(string: content.urlString) {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    imageOfTheDayImageView.image = image
                }
            }
            /*
             Load image on wkwebview
             videoView = WKWebView(frame: mediaContainerView.bounds, configuration: WKWebViewConfiguration())
             videoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
             self.mediaContainerView.addSubview(videoView)
             videoView.load(URLRequest(url: URL(string: content.urlString)!))
             */
        }
    }
}
