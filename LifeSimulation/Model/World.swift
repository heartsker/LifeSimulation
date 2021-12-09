//
//  GlobalPreferences.swift
//  LifeSimulation
//
//  Created by Daniel Pustotin on 08.12.2021.
//

import Foundation

class World: ObservableObject {
    static let shared = World()
    
    let mutationRate = 0.1
    let steps = 10000
    @Published var creatures: [Creature] = []
    @Published var food: [Point] = []
    var delay: UInt32 = 1000
    var creatureCount = 100
    var leftSteps = 0
    @Published var generation: Int = 0
    var averageSpeed: Double = 0
    var averageAggression: Double = 0
    var predator: Int = 0
    var herbivore: Int = 0
    
    var energyOfFood: Double = 1
    var foodCount: Int = 50
    var energyOfCreature: Double = 5
    var reproductiveChance: Double = 0.5
    
    func renewFood() {
        while food.count < foodCount {
            food.append(Point.random())
        }
    }
    
    func renewCreatures() {
        while creatures.count < creatureCount {
            creatures.append(Creature.random())
        }
    }
    
    func simulateOneStep() {
        renewFood()
        if leftSteps == 0 {
            newDay()
        }
        
        creatures.forEach { $0.moveToTarget(food: food, creatures: creatures) }
        
        creatures.forEach { creature in
            if creature.checkDestination() {
                food.removeAll { $0 == creature.target }
                creatures.removeAll { $0.position == creature.target && $0 != creature }
                creature.removeTarget()
            }
        }
        
        creatures.forEach { creature in
            if let target = creature.target, !food.contains(target) {
                creature.removeTarget()
            }
            if let target = creature.target, !creatures.contains(where: { $0.position == target && $0 != creature }) {
                creature.removeTarget()
            }
        }
        
        var newCreatures: [Creature] = []
        creatures.forEach {
            if let new = $0.tryProcreate() {
                newCreatures.append(new)
            }
        }
        creatures.append(contentsOf: newCreatures)
        
        leftSteps -= 1
        
        creatures.removeAll { !$0.isAlive }
        averageSpeed = creatures.reduce(0, {$0 + $1.speed}) / Double(creatures.count)
        averageAggression = creatures.reduce(0, {$0 + $1.aggression}) / Double(creatures.count)
        predator = creatures.reduce(0, {$0 + ($1.isAggressive ? 1 : 0) })
        herbivore = creatures.count - predator
    }
    
    func newDay() {
        generation += 1
        leftSteps = steps
        
        
        creatures.forEach { $0.nextDay() }
        
    }
    
    func start() {
        renewFood()
        renewCreatures()
        newDay()
    }
    
    func simulate() {
        while true {
            newDay()
            sleep(delay)
        }
    }
}

let world = World.shared
