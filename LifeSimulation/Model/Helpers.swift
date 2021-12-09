//
//  Helpers.swift
//  LifeSimulation
//
//  Created by Daniel Pustotin on 08.12.2021.
//

import Foundation

extension Double {
    var normalized: Self {
        min(1, max(0, self))
    }
}
