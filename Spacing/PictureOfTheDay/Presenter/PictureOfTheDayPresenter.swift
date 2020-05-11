//
//  PictureOfTheDayPresenter.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

class PictureOfTheDayPresenter: PictureOfTheDayPresenterProtocol {
    
    weak var view: PictureOfTheDayViewProtocol?
    var interactor: PictureOfTheDayInputInteractorProtocol?
    var wireframe: PictureOfTheDayWireframeProtocol?
    
    func fetchImageBy(date: Date, hd: Bool) {
        view?.showLoading()
        interactor?.fetchImageBy(date: date, hd: hd)
    }
    
    func viewDidLoad() {
        view?.showLoading()
        view?.render()
        interactor?.fetchContent()
    }
}

extension PictureOfTheDayPresenter: PictureOfTheDayOutputInteractorProtocol {
    
    func didReceived(content: PictureOfTheDay) {
        view?.removeLoading()
        view?.load(content)
    }
    
    func showError(_ message: String) {
        view?.removeLoading()
        view?.showError(message)
    }
}

