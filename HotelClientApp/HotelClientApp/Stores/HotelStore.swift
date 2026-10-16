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
    private var currentPage: Int = 1
    private var hasMoreHotels: Bool = true
    
    private var sortOption: SortOption?
    private var filters: Set<FilterOption>?
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadHotels(sortOption: SortOption? = nil, filters: Set<FilterOption>? = nil, pageSize: Int = 10) async throws {
        
        let queryChanged = (self.sortOption != sortOption) || (self.filters != filters)
        let page = queryChanged ? 1: currentPage
        
        guard queryChanged || hasMoreHotels else { return }
        
        let resource = Resource(url: Constants.URLs.hotels(sort: sortOption, filters: filters, page: page, pageSize: pageSize), responseType: [Hotel].self)
        print(resource.url)
        let newHotels = try await httpClient.fetch(resource: resource)
        
        if page == 1 {
            hotels = newHotels
        } else {
            hotels.append(contentsOf: newHotels)
        }
        
        self.sortOption = sortOption
        self.filters = filters
        
        currentPage = page + 1
        hasMoreHotels = newHotels.count == pageSize
    }
}
