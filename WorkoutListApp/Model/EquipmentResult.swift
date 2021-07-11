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


/**
 {
    "count":10,
    "next":null,
    "previous":null,
    "results":[
       {
          "id":1,
          "name":"Barbell"
       },
       {
          "id":8,
          "name":"Bench"
       },
       {
          "id":3,
          "name":"Dumbbell"
       },
       {
          "id":4,
          "name":"Gym mat"
       },
       {
          "id":9,
          "name":"Incline bench"
       },
       {
          "id":10,
          "name":"Kettlebell"
       },
       {
          "id":7,
          "name":"none (bodyweight exercise)"
       },
       {
          "id":6,
          "name":"Pull-up bar"
       },
       {
          "id":5,
          "name":"Swiss Ball"
       },
       {
          "id":2,
          "name":"SZ-Bar"
       }
    ]
 }
 */
