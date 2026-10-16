//
//  HotelListScreen.swift
//  HotelClientApp
//
//  Created by Mohammad Azam on 10/12/26.
//

import SwiftUI

struct HotelListScreen: View {
    
    @Environment(HotelStore.self) private var hotelStore
    
    //@State private var sortOption: SortOption?
    //@State private var filters: Set<FilterOption> = []
    @State private var activeSheet: Sheet?
    //@State private var pageSize: Int = 10
    
    @State private var query = HotelQuery()
    
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
            
            PageSizeView(initialPageSize: query.pageSize) { pageSize in
                query.pageSize = pageSize
                //self.pageSize = pageSize
                Task { await loadHotels() }
            }
            
            ForEach(hotelStore.hotels) { hotel in
                HotelCellView(hotel: hotel)
                    .task {
                        if hotel.id == hotelStore.hotels.last?.id {
                            await loadHotels()
                        }
                    }
            }
        }
        .safeAreaInset(edge: .bottom) {
            if hotelStore.isLoading {
                ProgressView("Loading hotels...")
                    .controlSize(.regular)
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .background(.regularMaterial)
            }
        }
        .sheet(item: $activeSheet, content: { sheet in
            switch sheet {
                case .filter:
                FilterView(initialFilters: query.filters) { filters in
                    query.filters = filters
                    Task { await loadHotels() }
                }.presentationDetents([.fraction(0.25)])
                case .sort:
                SortView(initialSelection: query.sort) { option in
                    query.sort = option
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
            try await hotelStore.loadHotels(query)
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
