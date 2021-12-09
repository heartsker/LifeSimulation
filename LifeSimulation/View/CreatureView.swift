//
//  CreatureView.swift
//  LifeSimulation
//
//  Created by Daniel Pustotin on 08.12.2021.
//

import SwiftUI

struct CreatureView: View {
    @ObservedObject var creature: Creature
    var body: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundColor(creature.isAggressive ? .red : .green)
            .position(CGPoint(x: creature.position.x * radius, y: creature.position.y * radius))
    }
}

struct CreatureView_Previews: PreviewProvider {
    static var previews: some View {
        CreatureView(creature: Creature.random())
    }
}
