//
//  PlacesModel.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/10/23.
//

import Foundation
struct Places: Codable{
    let results:[Place]?
    let context: Geobounds?
}

struct Geobounds: Codable{
    let circle: Circle?
}

struct Circle: Codable{
    let center: Coordinates?
    let radius: Int?
}

struct Place: Codable{
    let fsq_id: String?
    let categories: [Category]?
    let chains: [String]?
    let distance: Int?
    let geocodes: Geocode?
    let link:String?
    let location: Location?
    let name:String?
}

struct Category: Codable{
    let id: Int
    let name: String?
    let icon: IconUrl?
}

struct IconUrl: Codable{
    let prefix: String?
    let suffix: String?
}

struct Geocode: Codable{
    let main: Coordinates?
    let roof: Coordinates?
}

struct Coordinates: Codable{
    let latitude: Double?
    let longitude: Double?
}
struct Location: Codable{
    let address: String?
    let census_block: String?
    let country: String?
    let cross_street:String?
    let dma: String?
    let formatted_address:String?
    let locality:String?
    let neighborhood:[String]?
    let postcode:String?
    let region:String?
}

