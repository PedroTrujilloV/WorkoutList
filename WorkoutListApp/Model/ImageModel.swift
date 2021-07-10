//
//  ImageModel.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/10/21.
//

import Foundation


struct ImageModel: Codable {
    var thumbnail:ThumbnailModel
}



/** example:
 {
    "micro":{
       "url":"/media/exercise-images/177/Seated-leg-curl-1.png.30x30_q85.jpg",
       "settings":{
          "size":[
             30,
             30
          ]
       }
    },
    "micro_cropped":{
       "url":"/media/exercise-images/177/Seated-leg-curl-1.png.30x30_q85_crop-smart.jpg",
       "settings":{
          "size":[
             30,
             30
          ],
          "crop":"smart"
       }
    },
    "thumbnail":{
       "url":"/media/exercise-images/177/Seated-leg-curl-1.png.80x80_q85.jpg",
       "settings":{
          "size":[
             80,
             80
          ]
       }
    },
    "thumbnail_cropped":{
       "url":"/media/exercise-images/177/Seated-leg-curl-1.png.80x80_q85_crop-smart.jpg",
       "settings":{
          "size":[
             80,
             80
          ],
          "crop":"smart"
       }
    },
    "small":{
       "url":"/media/exercise-images/177/Seated-leg-curl-1.png.200x200_q85.jpg",
       "settings":{
          "size":[
             200,
             200
          ]
       }
    },
    "small_cropped":{
       "url":"/media/exercise-images/177/Seated-leg-curl-1.png.200x200_q85_crop-smart.jpg",
       "settings":{
          "size":[
             200,
             200
          ],
          "crop":"smart"
       }
    },
    "medium":{
       "url":"/media/exercise-images/177/Seated-leg-curl-1.png.400x400_q85.jpg",
       "settings":{
          "size":[
             400,
             400
          ]
       }
    },
    "medium_cropped":{
       "url":"/media/exercise-images/177/Seated-leg-curl-1.png.400x400_q85_crop-smart.jpg",
       "settings":{
          "size":[
             400,
             400
          ],
          "crop":"smart"
       }
    },
    "large":{
       "url":"/media/exercise-images/177/Seated-leg-curl-1.png.800x800_q90.jpg",
       "settings":{
          "size":[
             800,
             800
          ],
          "quality":90
       }
    },
    "large_cropped":{
       "url":"/media/exercise-images/177/Seated-leg-curl-1.png.800x800_q90_crop-smart.jpg",
       "settings":{
          "size":[
             800,
             800
          ],
          "crop":"smart",
          "quality":90
       }
    },
    "original":"/media/exercise-images/177/Seated-leg-curl-1.png"
 }
 
 */
