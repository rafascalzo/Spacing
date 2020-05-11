//
//  MarsRoverInputInteractor.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

// earth_date    YYYY-MM-DD    none    sol (ranges from 0 to max found in endpoint)
// camera        string    all    see table above for abbreviations
// page          int    1    25 items per page returned
// api_key       string    DEMO_KEY    api.nasa.gov key for expanded usage

class MarsRoverInputInteractor: MarsRoverInputInteractorProtocol {
    
    weak var output: MarsRoverOutputInteractorProtocol?
    
    func fetchByEarthDate(rover: RoverName, camera: RoverCamera, date: Date?, page: Int) {
        if !camera.availableInRovers().contains(rover){
            self.output?.showError("invalid_camera")
        } else {
            var earthDate = ""
            if let date = date {
                earthDate = Date.stringValue(from: date, pattern: .yearMonthDay)
            } else {
                earthDate = Date.stringValue(from: Date(), pattern: .yearMonthDay)
            }
            let parameters = MarsEarthDateQueryingParameters(authenticated: true, rover: rover.name, earthDate: earthDate, camera: camera.value, page: page)
            
            NASAAPI.Curiosity.queryByEarthDate(rover: rover, queryParameters: parameters) { (photos, error) in
                if let error = error {
                    print(error)
                    self.output?.showError(error)
                } else if let photos = photos {
                    print("eba")
                    self.output?.didFetch(roverPhotos: photos)
                }
            }
        }
    }
    
    func fetchByMartianSol(rover: RoverName, camera: RoverCamera?, sol: Int? = nil, page: Int) {
        
        let parameters = MartianSolInputParameters(authenticated: true, sol: sol, camera: camera?.name, page: 1)
        
        NASAAPI.Curiosity.queryByMartianSol(rover: rover, queryParameters: parameters) { (photos, error) in
            if let error = error {
                print(error)
                self.output?.showError(error)
            } else if let photos = photos {
                self.output?.didFetch(roverPhotos: photos)
            }
        }
    }
}
