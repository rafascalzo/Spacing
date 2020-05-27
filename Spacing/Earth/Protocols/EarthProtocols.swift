//
//  EarthProtocols.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

protocol EarthViewProtocol: class {
    
    var presenter: EarthPresenterProtocol? { get set }
    
    func render()
    func showLoading()
    func removeLoading()
    func showError(_ message: String)
    func didFetchImage(_ base64String: String)
}

protocol EarthInputInteractorProtocol: class {
    
    var output: EarthOutputInteractorProtocol? { get set }
    
    func fetchImage(parameters: EarthImageryQueryParameters)
}

protocol EarthPresenterProtocol: class {
    
    var view: EarthViewProtocol? { get set }
    var interactor: EarthInputInteractorProtocol? { get set }
    var wireframe: EarthWireframeProtocol? { get set }
    
    func viewDidLoad()
}

protocol EarthOutputInteractorProtocol: class {
    func didFetchImage(_ base64String: String)
    func showError(_ message: String)
}

protocol EarthWireframeProtocol: class {
    
    var controller: EarthView? { get set }
    
    static func createModule(viewRef: EarthView)
}
