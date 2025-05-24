//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Rob Ranf on 5/7/25.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(Favorites.self) var favorites

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    Text("Credit: \(resort.imageCredit)")
                        .padding(3)
                        .background(.black.opacity(0.7))
                        .foregroundStyle(.white)
                        .font(horizontalSizeClass == .compact ? .caption : .callout)
                        .offset(x: -5, y: -5) // Always do the offset after you have finished styling the content
                }
                    
                HStack {
                    if horizontalSizeClass == .compact
                        && dynamicTypeSize > .large
                    {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))

                Group {
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            selectedFacility?.name ?? "More Information",
            isPresented: $showingFacility,
            presenting: selectedFacility
            // Using _ in here for the alert's action closure because we don't actually care
            // about getting the unwrapped Facility instance here, but it is important
            // in the message closure so we can display the correct description.
        ) { _ in
        } message: { facility in
            Text(facility.description)
        }

        Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
            if favorites.contains(resort) {
                favorites.remove(resort)
            } else {
                favorites.add(resort)
            }
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }
}

#Preview {
    ResortView(resort: .example)
        .environment(Favorites())
}
