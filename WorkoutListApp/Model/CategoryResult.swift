//
//  CategoryResult.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/10/21.
//

import Foundation

struct CategoryResult: Codable {
    var count:Int
    var next: String?
    var previous: String?
    var results: Array<CategoryModel>
}


/**
 https://wger.de/api/v2/exercisecategory/?format=json
 {
     "count": 7,
     "next": null,
     "previous": null,
     "results": [
         {
             "id": 10,
             "name": "Abs"
         },
         {
             "id": 8,
             "name": "Arms"
         },
         {
             "id": 12,
             "name": "Back"
         },
         {
             "id": 14,
             "name": "Calves"
         },
         {
             "id": 11,
             "name": "Chest"
         },
         {
             "id": 9,
             "name": "Legs"
         },
         {
             "id": 13,
             "name": "Shoulders"
         }
     ]
 }
 
 */
