//
//  EarthWireframe.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

class EarthWireframe: EarthWireframeProtocol {
    
    weak var controller: EarthView?
    
    static func createModule(viewRef: EarthView) {
        let presenter: EarthPresenterProtocol & EarthOutputInteractorProtocol = EarthPresenter()
        
        viewRef.presenter = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.interactor = EarthInputInteractor()
        viewRef.presenter?.interactor?.output = presenter
        viewRef.presenter?.wireframe = EarthWireframe()
        viewRef.presenter?.wireframe?.controller = viewRef
    }
    
    deinit {
        print("Earth wireframe has removed", #file, #function, #line)
    }
}
