//
//  EPICProtocols.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

protocol EpicViewProtocol: class {
    
    var presenter: EpicPresenterProtocol? { get set }
    
    func render()
}

protocol EpicInputInteractorProtocol: class {
    
}

protocol EpicPresenterProtocol: class {
    
    var view: EpicViewProtocol? { get set }
    var interactor: EpicInputInteractorProtocol? { get set }
    var wireframe: EpicWireframeProtocol? { get set }
    
    func viewDidLoad()
}

protocol EpicOutputInteractorProtocol: class {
    
}

protocol EpicWireframeProtocol: class {
    var controller: EpicView? { get set }
    static func createModule(viewRef: EpicView)
}
