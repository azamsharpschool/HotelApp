//
//  HotelQuery.swift
//  HotelClientApp
//
//  Created by Mohammad Azam on 10/16/26.
//

import Foundation

struct HotelQuery: Equatable {
    var sort: SortOption?
    var filters: Set<FilterOption> = []
    var pageSize: Int = 10
}
