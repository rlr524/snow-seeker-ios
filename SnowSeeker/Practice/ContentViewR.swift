//
//  ContentViewR.swift
//  snow-seeker
//
//  Created by Rob Ranf on 4/8/25.
//

import SwiftUI

struct ContentViewR: View {
    var body: some View {
        NavigationSplitView(preferredCompactColumn: .constant(.detail)) {
            NavigationLink("Primary") {
                Text("New View")
            }
        } detail: {
            Text("Content")
                .navigationTitle("Content View")
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    ContentViewR()
}
