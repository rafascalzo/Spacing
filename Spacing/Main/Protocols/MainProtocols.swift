//
//  MainProtocols.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

protocol MainViewProtocol: class {
    
    var presenter: MainPresenterProtocol? { get set }
    
    func render()
}

protocol MainInputInteractorProtocol: class {
    
}

protocol MainPresenterProtocol: class {
    
    var view: MainViewProtocol? { get set }
    var interactor: MainInputInteractorProtocol? { get set }
    var wireframe: MainWireframeProtocol? { get set }
    
    func viewDidLoad()
    func pushTo(scene: Scene)
}

protocol MainOutputInteractorProtocol: class {
    
}

protocol MainWireframeProtocol: class {
    
    var controller: MainView? { get set }
    
    static func createModule(viewRef: MainView)
    
    func pushTo(scene: Scene)
}
