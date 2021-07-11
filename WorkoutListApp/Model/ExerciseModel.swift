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
//    var exercise_base:Int?
//    var status:String?
    var description:String?
//    var creation_date:String?
    var category:Int?
//    var muscles:Array<Int>?
//    var muscles_secondary:Array<Int>?
//    var equipment:Array<Int>?
//    var language:Int
//    var license:Int
//    var license_author:String?
//    var variations:Array<Int>?
}


/** // example: 
 
 "id": 227,
 "uuid": "53ca25b3-61d9-4f72-bfdb-492b83484ff5",
 "name": "Arnold Shoulder Press",
 "exercise_base": 20,
 "status": "2",
 "description": "<p>Very common shoulder exercise.</p>\n<p> </p>\n<p>As shown here: https://www.youtube.com/watch?v=vj2w851ZHRM</p>",
 "creation_date": "2014-03-09",
 "category": 13,
 "muscles": [],
 "muscles_secondary": [],
 "equipment": [
 3
 ],
 "language": 2,
 "license": 1,
 "license_author": "trzr23",
 "variations": [
 227,
 329,
 229,
 190,
 119,
 123,
 152,
 155
 ]
 */
