//
//  PictureOfTheDayProtocols.swift
//  Spacing
//
//  Created by Rafael Scalzo on 10/05/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import Foundation

protocol PictureOfTheDayViewProtocol: class {
    
    var presenter: PictureOfTheDayPresenterProtocol? { get set }
    func render()
    func showError(_ message: String)
    func load(_ content: PictureOfTheDay)
    func showLoading()
    func removeLoading()
}

protocol PictureOfTheDayInputInteractorProtocol: class {
    
    var output: PictureOfTheDayOutputInteractorProtocol? { get set }
    
    func fetchContent()
    func fetchImageBy(date: Date, hd: Bool)
}

protocol PictureOfTheDayPresenterProtocol: class {
    
    var view: PictureOfTheDayViewProtocol? { get set }
    var interactor: PictureOfTheDayInputInteractorProtocol? { get set }
    var wireframe: PictureOfTheDayWireframeProtocol? { get set }
    
    func viewDidLoad()
    func fetchImageBy(date: Date, hd: Bool)
}

protocol PictureOfTheDayOutputInteractorProtocol: class {
    
    func didReceived(content: PictureOfTheDay)
    func showError(_ message: String)
}

protocol PictureOfTheDayWireframeProtocol: class {
    
    var controller: PictureOfTheDayView? { get set }
    
    static func createModule(viewRef: PictureOfTheDayView)
}

