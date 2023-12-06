//
//  EpicWireframe.swift
//  Spacing
//
//  Created by Rafael Scalzo on 11/05/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import Foundation

class EpicWireframe: EpicWireframeProtocol {
    
    weak var controller: EpicView?
    
    static func createModule(viewRef: EpicView) {
        
        let presenter: EpicPresenterProtocol & EpicOutputInteractorProtocol = EpicPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.interactor = EpicInputInteractor()
        viewRef.presenter?.interactor?.output = presenter
        viewRef.presenter?.wireframe = EpicWireframe()
        viewRef.presenter?.wireframe?.controller = viewRef
    }
    
    deinit {
        print("Epic wireframe has removed", #file, #function, #line)
    }
}

