//
//  ExerciseViewModel.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/9/21.
//

import Foundation
import UIKit

class ExerciseViewModel {
    
    private var baseURLString = "https://wger.de"
    private let model:ExerciseModel
    private var imageModel:ImageModel?
    
    var id:Int {
        return model.id 
    }

    var name:String {
        return model.name ?? ""
    }
    var description:String {
        return model.description ?? ""
    }
    
    var thumbnail:String {
        guard let imageModel = imageModel else {
            print("\n ⚠️ ExerciseViewModel.thumbnail: not image model for exercise \(id) \(name)")
            return ""
        }
        if imageModel.thumbnail.url == "" { return "" }
        return baseURLString + imageModel.thumbnail.url
    }
    //https://wger.de/api/v2/exerciseimage/167/?format=json&language=2 // full image
    
    public func getImageURL(completion: @escaping (URL) -> Void) {
        let thumbnail = self.thumbnail
        DataSource.retrieveImageModel(with: id) { [weak self] imageModel in
            self?.imageModel = imageModel
            
            guard let url = URL(string: thumbnail) else {
                print("\n ⚠️ ExerciseViewModel.getImageURL(): There was a problem getting URL from: \(thumbnail)")
                return
            }
            completion(url)
        }
    }
    
    init(model:ExerciseModel) {
        self.model = model
    }
}

