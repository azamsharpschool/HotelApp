//
//  SortOption.swift
//  HotelClientApp
//
//  Created by Mohammad Azam on 10/12/26.
//

import Foundation

enum SortOption: String, CaseIterable, Identifiable, Equatable {
    
    case priceLowToHigh
    case priceHighToLow
    case guestRating

    var id: Self { self }
    
    var title: String {
        switch self {
        case .priceLowToHigh:
            return "Price: Low to High"
        case .priceHighToLow:
            return "Price: High to Low"
        case .guestRating:
            return "Guest Rating"
        }
    }
}
