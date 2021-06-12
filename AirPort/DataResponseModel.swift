//
//  DataResponseModel.swift
//  AirPort
//
//  Created by Juan Antonio Martin on 09/06/21.
//

import Foundation
import UIKit



struct DataResponseModel: Codable {
    
    let icao: String
    let iata: String
    let name: String
    let shortName: String
    let municipalityName: String
    let location: LocationItem
    let countryCode: String
    
}

struct LocationItem: Codable {
    let lat: Float
    let lon: Float
    
}

struct DataItem: Codable {
    let items : [DataResponseModel]
}


