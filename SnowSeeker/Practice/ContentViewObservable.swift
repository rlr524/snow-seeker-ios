//
//  ContentViewObservable.swift
//  SnowSeeker
//
//  Created by Rob Ranf on 5/5/25.
//

import SwiftUI

@Observable
class Player {
    var name = "Madison"
    var highScore = 0
}

struct HighScoreView: View {
    @Environment(Player.self) var player

    var body: some View {
        @Bindable var player = player
        Stepper("High score: \(player.highScore)", value: $player.highScore)
    }
}

struct ContentViewObservable: View {
    @State private var madison = Player()

    var body: some View {
        VStack {
            Text("Welcome")
            HighScoreView()
        }
        .environment(madison)
    }
}

#Preview {
    ContentViewObservable()
}
