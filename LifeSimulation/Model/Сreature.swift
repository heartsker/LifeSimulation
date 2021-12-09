//
//  Сreature.swift
//  LifeSimulation
//
//  Created by Daniel Pustotin on 08.12.2021.
//

import Foundation

final class Creature: Hashable, Identifiable, ObservableObject {
    
    static func == (lhs: Creature, rhs: Creature) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @Published private(set) var aggression: Double
    @Published private(set) var speed: Double
    @Published private(set) var reproductiveChance: Double
    @Published private(set) var energy: Double
    @Published private(set) var position: Point
    @Published private(set) var target: Point?
    @Published private(set) var direction: Point = Point(0, 0)
    @Published private(set) var stepEnergy: Double = 0.00001
    @Published private(set) var isAggressive: Bool!
    @Published var age: Int
    private(set) var maxAge: Int
    
    var id = UUID()
    
    init(agression: Double, speed: Double, energy: Double) {
        self.aggression = agression
        self.speed = speed
        reproductiveChance = world.reproductiveChance / 100
        self.energy = energy
        position = Point.random()
        age = 0
        maxAge = 5
        isAggressive = Double.random(in: 0...1) < aggression
    }
    
    static func random() -> Creature {
        Creature(agression: Double.random(in: 0...1), speed: Double.random(in: 0...1), energy: Double.random(in: 2 ... 5))
    }
    
    var isAlive: Bool {
        energy > speed && age < maxAge
    }
    
    func tryProcreate() -> Creature? {
        Double.random(in: 0...1) <= reproductiveChance ? offspring() : nil
    }
    
    private func offspring() -> Creature {
        let agressionNew = (aggression * (1 + Double.random(in: -world.mutationRate ... world.mutationRate))).normalized
        let speedNew = (speed * (1 + Double.random(in: -world.mutationRate ... world.mutationRate))).normalized
        let energyNew = energy / 2
        energy /= 2
        
        return Creature(agression: agressionNew, speed: speedNew, energy: energyNew)
    }
    
    func moveToTarget(food: [Point], creatures: [Creature]) {
        findTarget(food: food, creatures: creatures)
        position = Point(position.x + speed / 100 * direction.x, position.y + speed / 100 * direction.y)
        energy -= stepEnergy * (1 + speed) * (1 + speed) * (1 + speed)
    }
    
    func findTarget(food: [Point], creatures: [Creature]) {
        if target != nil {
            return
        }
        if isAggressive {
            if creatures.count < 2 {
                removeTarget()
                return
            }
            target = creatures[0] == self ? creatures[1].position : creatures[0].position
            var dist = position.distance(to: target!)
            for creature in creatures {
                if creature == self {
                    continue
                }
                let cur = position.distance(to: creature.position)
                if dist > cur {
                    dist = cur
                    target = creature.position
                }
            }
        } else {
            if food.isEmpty {
                removeTarget()
                return
            }
            target = food[0]
            var dist = position.distance(to: target!)
            for point in food {
                let cur = position.distance(to: point)
                if dist > cur {
                    dist = cur
                    target = point
                }
            }
        }
        
        direction = Point((target!.x - position.x) / target!.distance(to: position), (target!.y - position.y) / target!.distance(to: position))
    }
    
    func checkDestination() -> Bool {
        if target != nil && position == target! {
            eat()
            return true
        }
        return false
    }
    
    func removeTarget() {
        target = nil
        direction = Point(0, 0)
    }
    
    func eat() {
        energy += isAggressive ? world.energyOfCreature : world.energyOfFood
    }
    
    func nextDay() {
        energy -= (1 + speed) * (1 + speed) * (1 + speed)
        age += 1
    }
    
    func setRandomPosition() {
        position = Point.random()
    }
}
