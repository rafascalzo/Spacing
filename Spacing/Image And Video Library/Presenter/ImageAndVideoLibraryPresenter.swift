//
//  ImageAndVideoLibraryPresenter.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

class ImageAndVideoLibraryPresenter: ImageAndVideoLibraryPresenterProtocol {
    
    weak var view: ImageAndVideoLibraryViewProtocol?
    var interactor: ImageAndVideoLibraryInputInteractorProtocol?
    var wireframe: ImageAndVideLibraryWireframeProtocol?
    
    func viewDidLoad() {
        view?.render()
    }
}

extension ImageAndVideoLibraryPresenter: ImageAndVideoLibraryOutputInteractorProtocol {
    
}
