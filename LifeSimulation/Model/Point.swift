//
//  Point.swift
//  LifeSimulation
//
//  Created by Daniel Pustotin on 08.12.2021.
//

import Foundation

final class Point: Equatable, Hashable, Identifiable, ObservableObject {
    static func == (lhs: Point, rhs: Point) -> Bool {
        max(abs(lhs.x - rhs.x), abs(lhs.y - rhs.y)) < 0.01
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    
    @Published var x: Double
    @Published var y: Double
    
    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
    
    static func randomPointOnCircumference() -> Point {
        let len = Double.random(in: 0...(2 * Double.pi))
        return Point(cos(len), sin(len))
    }
    
    static func random() -> Point {
        let r = sqrt(Double.random(in: 0...1))
        let phi = Double.random(in: 0...1) * 2 * Double.pi
        let x = r * cos(phi)
        let y = r * sin(phi)
        return Point(x, y)
    }
    
    func distance(to point: Point) -> Double {
        sqrt((x - point.x) * (x - point.x) + (y - point.y) * (y - point.y))
    }
}
