//
//  ContentView.swift
//  Learn
//
//  Created by Mohammad Azam on 5/27/26.
//

import SwiftUI

struct Constants {

    struct URLs {

        static let base = URL(string: "http://localhost:8080/api/")!

        static func hotels(query: HotelQuery, page: Int = 1) -> URL {

            let url = base.appending(path: "hotels")

            var queryItems: [URLQueryItem] = [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "limit", value: String(query.pageSize))
            ]

            if let sort = query.sort {
                queryItems.append(
                    URLQueryItem(
                        name: "sort",
                        value: sort.rawValue
                    )
                )
            }

            
            for option in query.filters {
                    queryItems.append(
                        URLQueryItem(
                            name: option.rawValue,
                            value: "true"
                        )
                    )
                }
            

            return url.appending(queryItems: queryItems)
        }
    }
}


