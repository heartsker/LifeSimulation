//
//  ContentView.swift
//  LifeSimulation
//
//  Created by Daniel Pustotin on 08.12.2021.
//

import SwiftUI

let screen = UIScreen.main.bounds
let size2 = CGSize(width: screen.width / 2, height: screen.height / 2)

let radius = min(screen.width, screen.height) / 2 - 25

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black
            PlaneView(world: world)
            InfoView(world: world)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
