//
//  MainPresenter.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation
class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var interactor: MainInputInteractorProtocol?
    var wireframe: MainWireframeProtocol?
    
    func viewDidLoad() {
        view?.render()
    }
    
    func pushTo(scene: Scene) {
        wireframe?.pushTo(scene: scene)
    }
}

extension MainPresenter: MainOutputInteractorProtocol {
    
}
