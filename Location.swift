//
//  location.swift
//  mental_health_proj
//
//  Created by Jiehong Lin on 4/25/19.
//  Copyright © 2019 Mitchell Lin. All rights reserved.
//

import Foundation

protocol Filter {
    var filterTitle: String { get }
}

enum ResourceType: Filter {
    case emergency
    case ears
    case letstalk
    case group
    case morning
    case afternoon
    case evening
    case north
    case central
    
    var filterTitle: String { //return the enum title with first letter uppercased
        return String(describing: self).localizedUppercase
    }
    
    static func allValues() -> [ResourceType] {
        return [.emergency,.ears,.letstalk,.group,.morning,.afternoon,.evening,.north,.central]
    }
}

//enum Favorite: Filter {
//    case favorite
//    case notfavorite
//
//    var filterTitle: String {
//        return String(describing: self).localizedUppercase
//    }
//
//    static func allValues() -> [Favorite] {
//        return [.favorite,.notfavorite]
//    }
//}

enum Time: Filter {
    case morning
    case afternoon
    case evening
    
    var filterTitle: String {
        return String(describing: self).localizedUppercase
    }
    
    static func allValues() -> [Time] {
        return [.morning,.afternoon,.evening]
    }
}

enum Type: Filter {
    case ears
    case letstalk
    case group
    case emergency
    
    var filterTitle: String {
        return String(describing: self).localizedUppercase
    }
    
    static func allValues() -> [Type] {
        return [.ears,.letstalk,.group,.emergency]
    }
}

enum LocationType: Filter {
    case north
    case central
    
    var filterTitle: String {
        return String(describing: self).localizedUppercase
    }
    
    static func allValues() -> [LocationType] {
        return [.north,.central]
    }
}

class Location{
    
    var name: String
    var image: String
    var phone: String
    var hours: String
    var address: String
    var website: String
    //let favorites: [Favorite]
    let types: [Type]
    let times: [Time]
    let locations: [LocationType]
    let coords: [Double]
    
    init(name: String, image: String, phone: String, hours: String, address: String, website: String, types:  [Type], times: [Time], locations: [LocationType], coords: [Double]) {
        self.name = name
        self.image = image
        self.phone = phone
        self.hours = hours
        self.address = address
        self.website = website
        self.types = types
        self.times = times
        self.locations = locations
        self.coords = coords
    }
}

struct locationStruct: Codable {
    var name: String
    var img: String
    var phone: String
    var hours: String
    var address: String
    var website: String
    var types: String
    var times: String
    var locations: String
    var coordinates: String
}

struct locationResponse: Codable {
    var data: [locationStruct]
}
