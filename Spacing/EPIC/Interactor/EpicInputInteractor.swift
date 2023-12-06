//
//  EpicInputInteractor.swift
//  Spacing
//
//  Created by Rafael Scalzo on 11/05/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

/*
 Parameter    Type    Default    Description
 natural    string    Most Recent Natural Color    Retrieve metadata on the most recent date of natural color imagery.
 natural/date    YYYY-MM-DD    Most Recent Available    Retrieve metadata for natural color imagery available for a given date.
 natural/all    string    Dates for Natural Color    Retrieve a listing of all dates with available natural color imagery.
 natural/available    string    Dates for Natural Color    Retrieve a listing of all dates with available natural color imagery.
 enhanced    string    Most Recent Enhanced Color    Retrieve metadata on the most recent date of enhanced color imagery.
 enhanced/date    YYYY-MM-DD    Most Recent Available    Retrieve metadata for enhanced color imagery for a given date.
 enhanced/all    string    Dates for Enhanced Imagery    Retrieve a listing of all dates with available enhanced color imagery.
 enhanced/available    string    Dates for Enhanced Imagery    Retrieve a listing of all dates with available enhanced color imagery.
 */


enum EPICParametersOptions {
    
    case most_recent, date, all, available
    
    var identifier: String {
        switch self {
        case .most_recent: return ""
        case .date: return "date"
        case .all: return "all"
        case .available: return "available"
        }
    }
}

enum ColorImageQuality {
    
    case natural, enhanced
    
    var identifier: String {
        switch self {
        case .natural: return "natural"
        case .enhanced: return "enhanced"
        }
    }
}

struct EpicQueryingParameters: Codable {
    
    var colorImageQuality: String
    var parameterOption: String
    var date: String?
}

import Foundation
class EpicInputInteractor: EpicInputInteractorProtocol {
    
    weak var output: EpicOutputInteractorProtocol?
    
    func fetchImage(quality: ColorImageQuality, options: EPICParametersOptions, date: Date? = nil) {
       // var stringDate: String? = nil
        
        let parameters = EpicQueryingParameters(colorImageQuality: quality.identifier, parameterOption: options.identifier, date: nil)
        
        NASAAPI.EPICAPI.fetchImagery(parameters: parameters) { (data, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                self.output?.didFetchImageData(data)
            }
        }
        
    }
}
