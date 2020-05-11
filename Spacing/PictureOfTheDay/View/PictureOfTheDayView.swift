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

class PictureOfTheDayView: UIViewController, PictureOfTheDayViewProtocol {
    
    @IBOutlet var imageOfTheDayContainerView: UIView!
    @IBOutlet var imageOfTheDayTitleLabel: UILabel!
    @IBOutlet var imageOfTheDayImageView: UIImageView!
    @IBOutlet var imageOfTheDayDescriptionContainerTextField: UIView!
    @IBOutlet var imageOfTheDayDescriptionTextView: UITextView!
    
    var presenter: PictureOfTheDayPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PictureOfTheDayWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    func render() {
        view.backgroundColor = .blue
        imageOfTheDayDescriptionContainerTextField.alpha = 0.3
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
               imageOfTheDayImageView.alpha = 0
               // videoView.alpha = 1
               
              // videoView = WKWebView(frame: mediaContainerView.bounds, configuration: WKWebViewConfiguration())
               //videoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
              // self.mediaContainerView.addSubview(videoView)
               //videoView.load(URLRequest(url: URL(string: content.urlString)!))
           default:
               // videoView.alpha = 0
               imageOfTheDayImageView.alpha = 1
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
