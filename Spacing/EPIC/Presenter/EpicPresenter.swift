//
//  EpicPresenter.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation
class EpicPresenter: EpicPresenterProtocol {
    
    weak var view: EpicViewProtocol?
    var interactor: EpicInputInteractorProtocol?
    var wireframe: EpicWireframeProtocol?
    
    func viewDidLoad() {
        view?.render()
        interactor?.fetchImage(quality: .natural, options: .most_recent, date: nil)
    }
}

extension EpicPresenter: EpicOutputInteractorProtocol {
    
    func didFetchImageData(_ model: [EPICModel]) {
        view?.didFetchImages(model)
    }
    
    func show(error: String) {
        view?.show(error: error.localized)
    }
}
