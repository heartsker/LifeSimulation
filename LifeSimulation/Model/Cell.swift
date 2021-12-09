//
//  Cell.swift
//  LifeSimulation
//
//  Created by Daniel Pustotin on 09.12.2021.
//

import Foundation

protocol Cell {
    var position: Point {get set}
}

extension Cell: Equatable {
    func ==(lhs: Cell, rhs: Cell) -> Bool {
        lhs.position == rhs.position
    }
}
