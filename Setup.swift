//
//  Setup.swift
//  mental_health_proj
//
//  Created by Alina Kim on 4/26/19.
//  Copyright © 2019 Mitchell Lin. All rights reserved.
//

import Foundation

class Setup {
    
    static func getFilters() -> [Filter] {
        var filters: [Filter] = []
        //filters.append(contentsOf: Favorite.allValues().map({ f in f as Filter }))
        filters.append(contentsOf: Type.allValues().map({ f in f as Filter }))
        filters.append(contentsOf: Time.allValues().map({ f in f as Filter }))
        filters.append(contentsOf: LocationType.allValues().map({ f in f as Filter }))
        return filters
    }
}
