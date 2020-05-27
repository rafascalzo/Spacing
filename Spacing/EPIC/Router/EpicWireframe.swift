//
//  EpicWireframe.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

class EpicWireframe: EpicWireframeProtocol {
    
    weak var controller: EpicView?
    
    static func createModule(viewRef: EpicView) {
        let presenter: EpicPresenterProtocol & EpicOutputInteractorProtocol = EpicPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.interactor = EpicInputInteractor()
        viewRef.presenter?.wireframe = EpicWireframe()
        viewRef.presenter?.wireframe?.controller = viewRef
    }
    
    deinit {
        print("Epic wireframe has removed", #file, #function, #line)
    }
}

