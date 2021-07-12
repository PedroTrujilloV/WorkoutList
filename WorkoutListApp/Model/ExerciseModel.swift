//
//  ExerciseModel.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/9/21.
//

import Foundation

struct ExerciseModel: Codable {
    var id:Int
    var uuid:String?
    var name:String?
    var description:String?
    var category:Int?
    var equipment:Array<Int>?
}
