//
//  EarthPresenter.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

class EarthPresenter: EarthPresenterProtocol {
    
    weak var view: EarthViewProtocol?
    var interactor: EarthInputInteractorProtocol?
    var wireframe: EarthWireframeProtocol?
    
    func viewDidLoad() {
        view?.render()
        let parameters = EarthImageryQueryParameters(latitude: 1.5, longitude: 100.75, dimension: nil, date: "2014-02-01", cloudScore: false)
        view?.showLoading()
        interactor?.fetchImage(parameters: parameters)
    }
}

extension EarthPresenter: EarthOutputInteractorProtocol {
    
    func showError(_ message: String) {
        view?.removeLoading()
        view?.showError(message)
    }
    
    func didFetchImage(_ base64String: String) {
        view?.removeLoading()
        view?.didFetchImage(base64String)
    }
}
