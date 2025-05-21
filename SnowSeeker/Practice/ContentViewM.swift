//
//  ContentViewM.swift
//  SnowSeeker
//
//  Created by Rob Ranf on 4/17/25.
//

import SwiftUI

struct ContentViewM: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        if horizontalSizeClass == .compact {
            VStack {
                UserView()
            }
        } else {
            HStack {
                MadisonView()
            }
        }
    }
}

struct UserView: View {
    var body: some View {
        Text("User View")
    }
}

struct MadisonView: View {
    var body: some View {
        Text("Madison View")
    }
}

#Preview {
    ContentViewM()
}
