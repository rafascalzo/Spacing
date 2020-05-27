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
    }
}

extension EpicPresenter: EpicOutputInteractorProtocol {
    
}
