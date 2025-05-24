//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Rob Ranf on 5/5/25.
//

import SwiftUI

enum SortType {
    // Backticks allow use of a keyword as a string literal
    case `default`, alphabetical, country, runs
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var sortType = SortType.default
    @State private var showingSortOptions = false

    var filteredResults: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var sortedResults: [Resort] {
        switch sortType {
        case .default:
            filteredResults
        case .alphabetical:
            filteredResults.sorted { $0.name < $1.name }
        case .country:
            filteredResults.sorted { $0.country < $1.country }
        case .runs:
            filteredResults.sorted { $0.runs > $1.runs }
        }
    }

    var body: some View {
        NavigationSplitView {
            List(sortedResults) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }

                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Button("Change sort order", systemImage: "arrow.up.arrow.down") {
                    showingSortOptions = true
                }
            }
            .confirmationDialog("Sort order", isPresented: $showingSortOptions) {
                Button("Default") { sortType = .default}
                Button("Alphabetical") { sortType = .alphabetical }
                Button("By Country") { sortType = .country }
                Button("Number of Runs") { sortType = .runs }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
