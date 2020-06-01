//
//  MarsRoverProtocols.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

protocol MarsRoverViewProtocol: class {
    
    var presenter: MarsRoverPresenterProtocol? { get set }
    
    func render()
    func showLoading()
    func removeLoading()
    func didFetch(roverPhotos: MarsRoverPhotos)
    func showError(_ message: String)

}

protocol MarsRoverInputInteractorProtocol: class {
    
    var output: MarsRoverOutputInteractorProtocol? { get set }
    
    func fetchByEarthDate(rover: RoverName, camera: RoverCamera?, date: Date?, page: Int)
    func fetchByMartianSol(rover: RoverName, camera: RoverCamera?, sol: Int?, page: Int)
}

protocol MarsRoverPresenterProtocol: class {
    
    var view: MarsRoverViewProtocol? { get set }
    var interactor: MarsRoverInputInteractorProtocol? { get set }
    var wireframe: MarsRoverWireframeProtocol? { get set }
    
    func viewDidLoad()
    
    func popBack()
    func fetchByEarthDate(rover: RoverName, camera: RoverCamera?, date: Date?, page: Int)
    func fetchByMartianSol(rover: RoverName, camera: RoverCamera?, sol: Int?, page: Int)
}

protocol MarsRoverOutputInteractorProtocol: class {
    
    func didFetch(roverPhotos: MarsRoverPhotos)
    func showError(_ message: String)
}

protocol MarsRoverWireframeProtocol: class {
    
    var controller: MarsRoverView? { get set }
    static func createModule(viewRef: MarsRoverView)
    
    func popBack()
}
