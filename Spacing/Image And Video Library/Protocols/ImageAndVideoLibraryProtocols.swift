//
//  ImageAndVideoLibraryProtocols.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

protocol ImageAndVideoLibraryViewProtocol: class {
    
    var presenter: ImageAndVideoLibraryPresenterProtocol? { get set }
    
    func render()
}

protocol ImageAndVideoLibraryInputInteractorProtocol: class {
    
    func search()
}

protocol ImageAndVideoLibraryPresenterProtocol: class {
    
    var view: ImageAndVideoLibraryViewProtocol? { get set }
    var interactor: ImageAndVideoLibraryInputInteractorProtocol? { get set }
    var wireframe: ImageAndVideLibraryWireframeProtocol? { get set }
    
    func viewDidLoad()
}

protocol ImageAndVideoLibraryOutputInteractorProtocol: class {
    
}

protocol ImageAndVideLibraryWireframeProtocol: class {
    
    var controller: ImageAndVideoLibraryView? { get set }
    static func createModule(viewRef: ImageAndVideoLibraryView)
}
