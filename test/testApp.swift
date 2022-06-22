//
//  testApp.swift
//  test
//
//  Created by Muhammad Zahid Imran on 23/03/2022.
//

import SwiftUI

@main
struct testApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView()
                .environmentObject(SearchViewModel(repository: RemoteRepository()))
        }
    }
}
