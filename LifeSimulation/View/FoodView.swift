//
//  FoodView.swift
//  LifeSimulation
//
//  Created by Daniel Pustotin on 08.12.2021.
//

import SwiftUI

struct FoodView: View {
    @ObservedObject var food: Point
    var body: some View {
        Circle()
            .frame(width: 10, height: 10)
            .foregroundColor(.black)
            .position(CGPoint(x: food.x * radius, y: food.y * radius))
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView(food: Point.random())
    }
}
