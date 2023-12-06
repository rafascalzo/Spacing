//
//  EpicPresenter.swift
//  Spacing
//
//  Created by Rafael Scalzo on 11/05/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
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

//MARK: - EpicOutputInteractorProtocol
extension EpicPresenter: EpicOutputInteractorProtocol {
    
    func didFetchImageData(_ model: [EPICModel]) {
        view?.didFetchImages(model)
    }
    
    func show(error: String) {
        view?.show(error: error.localized)
    }
}
