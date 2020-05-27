//
//  MainWireframe.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation
import UIKit

class MainWireframe: MainWireframeProtocol {
    
    weak var controller: MainView?
    
    func pushTo(scene: Scene) {
        switch scene.scene {
        case .PICTURE_OF_THE_DAY:
            controller?.navigationController?.pushViewController(PictureOfTheDayView(nibName: "PictureOfTheDayView", bundle: .main), animated: true)
        case .MARS:
            controller?.navigationController?.pushViewController(MarsRoverView(nibName: "MarsRoverView", bundle: .main), animated: true)
            break
        case .IMAGE_AND_VIDEO_LIBRARY:
            controller?.navigationController?.pushViewController(ImageAndVideoLibraryView(nibName: "ImageAndVideoLibraryView", bundle: .main), animated: true)
            break
        case .EPIC:
            controller?.navigationController?.pushViewController(EpicView(nibName: "EpicView", bundle: .main), animated: true)
            break
        case .EARTH:
            controller?.navigationController?.pushViewController(EarthView(nibName: "EarthView", bundle: .main), animated: true)
        default:
            print("nowhere to go", #file, #function, #line)
        }
    }
    
    static func createModule(viewRef: MainView) {
        
        let presenter: MainPresenterProtocol & MainOutputInteractorProtocol = MainPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.interactor = MainInputInteractor()
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.wireframe = MainWireframe()
        viewRef.presenter?.wireframe?.controller = viewRef
    }
    
    deinit {
        print("MainWireframe has removed", #file, #function, #line)
    }
}
