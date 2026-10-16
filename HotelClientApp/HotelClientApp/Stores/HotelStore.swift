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
    private(set) var isLoading: Bool = false
    private var query = HotelQuery()
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadHotels(_ query: HotelQuery) async throws {
        
        guard !isLoading else { return }
        
        let queryChanged = self.query != query
        let page = queryChanged ? 1: currentPage
        
        guard queryChanged || hasMoreHotels else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        let resource = Resource(url: Constants.URLs.hotels(query: query, page: page), responseType: [Hotel].self)
        print(resource.url)
        let newHotels = try await httpClient.fetch(resource: resource)
        
        if page == 1 {
            hotels = newHotels
        } else {
            hotels.append(contentsOf: newHotels)
        }
        
        self.query = query
        
        currentPage = page + 1
        hasMoreHotels = newHotels.count == query.pageSize
    }
}
