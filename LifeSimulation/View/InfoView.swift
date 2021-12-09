//
//  InfoView.swift
//  LifeSimulation
//
//  Created by Daniel Pustotin on 09.12.2021.
//

import SwiftUI

struct InfoView: View {
    @ObservedObject var world: World
    var body: some View {
            VStack {
                HStack {
                    Text("\(world.predator)")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Spacer()
                    Text("Total creatures: \(world.creatures.count)")
                        .font(.largeTitle)
                    Spacer()
                    Text("\(world.herbivore)")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                }
                
                HStack {
                    VStack {
                        Text("Reproductive chance:")
                        Slider(value: Binding(get: {
                            world.reproductiveChance
                        }, set: {
                            world.reproductiveChance = $0
                        }) , in: 0...1)
                    }
                    .frame(height: screen.height / 15)
                    VStack {
                        Text("Food count:")
                        Slider(value: Binding(get: {
                            Double(world.foodCount)
                        }, set: {
                            world.foodCount = Int($0)
                        }) , in: 0...100)
                    }
                    .frame(height: screen.height / 15)
                }
                HStack {
                    VStack {
                        Text("Creature as food:")
                        Slider(value: Binding(get: {
                            world.energyOfCreature
                        }, set: {
                            world.energyOfCreature = $0
                        }) , in: 0...10)
                    }
                    .frame(height: screen.height / 15)
                    
                    VStack {
                        Text("Food as food:")
                        Slider(value: Binding(get: {
                            world.energyOfFood
                        }, set: {
                            world.energyOfFood = $0
                        }) , in: 0...10)
                    }
                    .frame(height: screen.height / 15)
                }
                
                Spacer()
                
                Button("Start") {
                    world.start()
                }
                .font(.largeTitle)
            }
            .font(.title3)
        .padding()
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(world: world)
    }
}
