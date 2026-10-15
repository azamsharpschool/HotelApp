//
//  HotelListScreen.swift
//  HotelClientApp
//
//  Created by Mohammad Azam on 10/12/26.
//

import SwiftUI

struct HotelListScreen: View {
    
    @Environment(HotelStore.self) private var hotelStore
    
    @State private var sortOption: SortOption?
    @State private var filters: Set<FilterOption> = []
    @State private var activeSheet: Sheet?
    
    private enum Sheet: Identifiable {
        case filter
        case sort
        
        var id: Self { self }
    }
    
    var body: some View {
        List {
            
            HStack {
                
                Button("Filter") {
                    activeSheet = .filter
                }.buttonStyle(.borderless)
                
                Spacer()
                Button("Sort") {
                    activeSheet = .sort
                }.buttonStyle(.borderless)
            }
            
            ForEach(hotelStore.hotels) { hotel in
                HotelCellView(hotel: hotel)
            }
        }
        .sheet(item: $activeSheet, content: { sheet in
            switch sheet {
                case .filter:
                FilterView(initialFilters: filters) { filters in
                    self.filters = filters
                    Task { await loadHotels() }
                }.presentationDetents([.fraction(0.25)])
                case .sort:
                SortView(initialSelection: sortOption) { option in
                    sortOption = option
                    Task { await loadHotels() }
                }.presentationDetents([.fraction(0.25)])
            }
        })
        .task {
            await loadHotels()
        }.navigationTitle("Hotels")
    }
    
    private func loadHotels() async {
        do {
            try await hotelStore.loadHotels(sortOption: sortOption, filters: filters)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    NavigationStack {
        HotelListScreen()
    }.environment(HotelStore(httpClient: HTTPClient()))
}
