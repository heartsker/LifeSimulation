//
//  PlaneView.swift
//  LifeSimulation
//
//  Created by Daniel Pustotin on 08.12.2021.
//

import SwiftUI

struct PlaneView: View {
    @ObservedObject var world: World
    
    let timer = Timer.publish(every: 0.0000001, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.gray)
                .padding(25)
            
            ForEach(world.food) { food in
                FoodView(food: food).id(food.hashValue)
            }
            .offset(x: size2.width, y: size2.height)
            
            ForEach(world.creatures) { creature in
                CreatureView(creature: creature)
            }
            .offset(x: size2.width, y: size2.height)
        }
        .ignoresSafeArea()
        .onReceive(timer) { _ in
            world.simulateOneStep()
        }
    }
}

struct PlaneView_Previews: PreviewProvider {
    static var previews: some View {
        PlaneView(world: world)
    }
}
