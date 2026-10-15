//
//  FilterOption.swift
//  HotelClientApp
//
//  Created by Mohammad Azam on 10/14/26.
//

import Foundation

enum FilterOption: String, Identifiable, CaseIterable {
    case breakfast
    case parking
    case airportShuttle
    case wifiIncluded
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .breakfast:
            return "Breakfast Included"
        case .parking:
            return "Free Parking"
        case .airportShuttle:
            return "Airport Shuttle"
        case .wifiIncluded:
            return "Wi-Fi Included"
        }
    }
}
