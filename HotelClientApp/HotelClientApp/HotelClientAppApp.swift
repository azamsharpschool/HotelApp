//
//  HotelClientAppApp.swift
//  HotelClientApp
//
//  Created by Mohammad Azam on 10/12/26.
//

import SwiftUI

@main
struct HotelClientAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HotelListScreen()
            }.environment(HotelStore(httpClient: HTTPClient()))
        }
    }
}
