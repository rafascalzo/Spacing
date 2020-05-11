//
//  MarsRoverPresenter.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class MarsRoverPresenter: MarsRoverPresenterProtocol {
    
    weak var view: MarsRoverViewProtocol?
    var interactor: MarsRoverInputInteractorProtocol?
    var wireframe: MarsRoverWireframeProtocol?
    
    func viewDidLoad() {
        view?.render()
    }
    
    func fetchByMartianSol(rover: RoverName, camera: RoverCamera?, sol: Int?, page: Int) {
        interactor?.fetchByMartianSol(rover: rover, camera: camera, sol: sol, page: page)
    }
    
    func fetchByEarthDate(rover: RoverName, camera: RoverCamera, date: Date?, page: Int) {
        interactor?.fetchByEarthDate(rover: rover, camera: camera, date: date, page: page)
    }
    
    func popBack() {
        wireframe?.popBack()
    }
}

extension MarsRoverPresenter: MarsRoverOutputInteractorProtocol {
    
    func didFetch(roverPhotos: MarsRoverPhotos) {
        view?.didFetch(roverPhotos: roverPhotos)
    }
    
    func showError(_ message: String) {
        view?.showError(message)
    }
}
