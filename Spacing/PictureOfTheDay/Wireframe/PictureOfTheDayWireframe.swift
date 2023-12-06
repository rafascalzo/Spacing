//
//  PictureOfTheDayWireframe.swift
//  Spacing
//
//  Created by Rafael Scalzo on 10/05/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import Foundation

class PictureOfTheDayWireframe: PictureOfTheDayWireframeProtocol {
    
    weak var controller: PictureOfTheDayView?
    
    static func createModule(viewRef: PictureOfTheDayView) {
        let presenter: PictureOfTheDayPresenterProtocol & PictureOfTheDayOutputInteractorProtocol = PictureOfTheDayPresenter()
        
        viewRef.presenter = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.interactor = PictureOfTheDayInputInteractor()
        viewRef.presenter?.interactor?.output = presenter
        viewRef.presenter?.wireframe = PictureOfTheDayWireframe()
        viewRef.presenter?.wireframe?.controller = viewRef
    }
    
    deinit {
        print("PictureOfTheDayWireframe has removed", #file, #function, #line)
    }
}
