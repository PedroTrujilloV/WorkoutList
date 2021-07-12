//
//  EquipmentResult.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/11/21.
//

import Foundation

struct EquipmentResult: Codable {
    var count:Int
    var next: String?
    var previous: String?
    var results: Array<EquipmentModel>
}

