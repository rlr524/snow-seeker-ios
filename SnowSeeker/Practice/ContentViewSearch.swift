//
//  ContentViewSearch.swift
//  SnowSeeker
//
//  Created by Rob Ranf on 5/5/25.
//

import SwiftUI

struct ContentViewSearch: View {
    @State private var searchText = ""
    let blackpink = ["Jisoo", "Rosé", "Jennie", "Lisa"]

    var filteredNames: [String] {
        if searchText.isEmpty {
            blackpink
        } else {
            blackpink.filter { $0.localizedStandardContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for who's in your area")
            .navigationTitle("Blackpink In Your Area")
        }
    }
}

#Preview {
    ContentViewSearch()
}
