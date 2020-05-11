//
//  PictureOfTheDayInputInteractor.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

class PictureOfTheDayInputInteractor: PictureOfTheDayInputInteractorProtocol {
    
    weak var output: PictureOfTheDayOutputInteractorProtocol?
    
    func fetchImageBy(date: Date, hd: Bool) {
        NASAAPI.shared.fetchPictureOfTheDay(date: date, hd: hd) { data, error in
            if let result = data {
                self.output?.didReceived(content: result)
            } else if let error = error {
                self.output?.showError(error)
            }
        }
    }
    
    func fetchContent() {
        let date = Date()
        NASAAPI.shared.fetchPictureOfTheDay(date: date, hd: true) { data, error in
            if let result = data {
                self.output?.didReceived(content: result)
            } else if let error = error {
                self.output?.showError(error)
            }
        }
    }
}
