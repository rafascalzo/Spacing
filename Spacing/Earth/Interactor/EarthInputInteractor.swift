//
//  EarthInputInteractor.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

class EarthInputInteractor: EarthInputInteractorProtocol {
    
    weak var output: EarthOutputInteractorProtocol?
    
    func fetchImage(parameters: EarthImageryQueryParameters) {
        
        NASAAPI.EARTH.fetchImagery(parameters: parameters) { (success, string) in
            if success {
                if let imageBase64String = string {
                    self.output?.didFetchImage(imageBase64String)
                } else {
                    self.output?.showError("Sem imagem")
                }
            } else {
                if let error = string {
                    self.output?.showError(error)
                } else {
                    self.output?.showError("Erro")
                }
            }
        }
    }
}
