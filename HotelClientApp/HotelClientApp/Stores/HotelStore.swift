//
//  HotelStore.swift
//  HotelClientApp
//
//  Created by Mohammad Azam on 10/12/26.
//

import Foundation
import Observation

@Observable
class HotelStore {
    
    private(set) var hotels: [Hotel] = []
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadHotels(sortOption: SortOption? = nil, filters: Set<FilterOption>? = nil) async throws {
        let resource = Resource(url: Constants.URLs.hotels(sort: sortOption, filters: filters), responseType: [Hotel].self)
        hotels = try await httpClient.fetch(resource: resource)
    }
}
