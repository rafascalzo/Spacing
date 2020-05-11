//
//  MarsRoverWireframe.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class MarsRoverWireframe: MarsRoverWireframeProtocol {
    
    weak var controller: MarsRoverView?
    
    func popBack() {
        controller?.navigationController?.popViewController(animated: true)
    }
    
    static func createModule(viewRef: MarsRoverView) {
        let presenter: MarsRoverPresenterProtocol & MarsRoverOutputInteractorProtocol = MarsRoverPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.interactor = MarsRoverInputInteractor()
        viewRef.presenter?.interactor?.output = presenter
        viewRef.presenter?.wireframe = MarsRoverWireframe()
        viewRef.presenter?.wireframe?.controller = viewRef
        
    }
    
    deinit {
        print("Mars rover wireframe has removed", #file, #function, #line)
    }
}
