//
//  FourSquareUrlOptionModels.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/10/23.
//

import Foundation

////     --url 'https://api.foursquare.com/v3/places/search?
//ll=41.8781%2C-87.6298
//&radius=100
//&open_now=true
//&sort=RATING' \
//     --url 'https://api.foursquare.com/v3/places/search?ll=41.8781%2C-87.6298&radius=100&open_now=true&near=Astoria%2C%20NY&sort=RATING' \

protocol FourSquareUrlOption{
    var urlOption:String {get}
}

struct FourSquareCoordinatesOption: FourSquareUrlOption{
    let coordinates: Coordinates
    var urlOption:String{
        "ll=\(coordinates.latitude),\(coordinates.longitude)"
    }
}

struct FourSquareRadiusOption: FourSquareUrlOption{
    let radius: Int
    var urlOption: String{
        "radius=\(radius)"
    }
}

struct FourSquareNearOption: FourSquareUrlOption{
    let near: String
    var urlOption: String{
        "near=\(near)"
    }
}

struct FourSquareCategoriesOption: FourSquareUrlOption{
    let categories: FourSquarePlaceCategoryTaxonomyCode
    var urlOption: String{
        "categories=\(categories)"
    }
}

struct FourSquareSortedPreferencesOption: FourSquareUrlOption{
    let preference: FourSquareSearchPreference
    var urlOption: String{
        "sort=\(preference)"
    }
}

struct FourSquareIsOpenNowOption: FourSquareUrlOption{
    let isOpenNow: Bool?
    var urlOption: String{
        return "open_now=true"
    }
}

enum FourSquareSearchPreference{
    case rating, distance, popularity
}

struct FourSquareAPIUrlOptions{
    let radius: FourSquareRadiusOption?
    var coordinates: FourSquareCoordinatesOption?
    var near: FourSquareNearOption?
    let isOpenNow: FourSquareIsOpenNowOption?
    let sortPreference: FourSquareSortedPreferencesOption?
    let category:FourSquareCategoriesOption
    
    init(radius: FourSquareRadiusOption?, coordinates: FourSquareCoordinatesOption?, near: FourSquareNearOption?, isOpenNow: FourSquareIsOpenNowOption?, sortPreference: FourSquareSortedPreferencesOption?, category: FourSquareCategoriesOption) {
        self.radius = radius
        self.coordinates = coordinates
        self.near = near
        self.isOpenNow = isOpenNow
        self.sortPreference = sortPreference
        self.category = category
    }
    
    init(startLocation: StartLocation, category: FourSquareCategoriesOption){
        self.isOpenNow = FourSquareIsOpenNowOption(isOpenNow: true)
        self.radius = FourSquareRadiusOption(radius: 10000) // the max radius
        self.sortPreference = FourSquareSortedPreferencesOption(preference: .rating)
        self.category = category
        self.coordinates = startLocation.coordinates.map{
            FourSquareCoordinatesOption(coordinates: $0)
        }
        self.near = startLocation.near.map{
            FourSquareNearOption(near: $0)
        }
    }
}

struct FourSquareAPIUrlOptionsMapper{
    let options:FourSquareAPIUrlOptions
    var urlString: String{
        let baseUrl = "https://api.foursquare.com/v3/places/search"
        guard let urlOptions = [
            options.coordinates, options.radius, options.category, options.isOpenNow, options.near, options.sortPreference
        ] as? [FourSquareUrlOption] else{
            return baseUrl
        }
        let urlWithOptions = urlOptions.compactMap{$0.urlOption}
            .reduce(baseUrl){
                $0.count > 0 ? "\($0)&\($1)" : $1
            }
        return urlWithOptions
    }
}

struct StartLocation{
    let coordinates: Coordinates?
    let near: String?
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
        self.near = nil
    }
    init(near: String){
        self.near = near
        self.coordinates = nil
    }
}
