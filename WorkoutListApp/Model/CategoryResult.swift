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
