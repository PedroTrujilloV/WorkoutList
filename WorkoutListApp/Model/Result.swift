//
//  Result.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/9/21.
//

import Foundation

struct Result: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: Array<ExerciseModel>
}

