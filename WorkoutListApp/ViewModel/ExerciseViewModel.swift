//
//  ExerciseViewModel.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/9/21.
//
//"https://wger.de/api/v2/exerciseimage/\(id)/?format=json&language=2" // full image


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
    
    var fullImage: String {
        guard let imageModel = imageModel else {
            print("\n ⚠️ ExerciseViewModel.fullImage: not image model for exercise \(id) \(name)")
            return ""
        }
        guard let original = imageModel.original else {
            print("\n ⚠️ ExerciseViewModel.fullImage : not original for exercise \(id) \(name)")
            return ""
        }
        if original == "" { return "" }
        return baseURLString + original
    }
    
    var categoryId: Int {
        return model.category ?? -1
    }
    
    var equipmen: Array<Int> {
        return model.equipment ?? []
    }
    
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
    
    public func getCategoryName( completion: @escaping (String)-> Void) {
        DataSource.retrieveCategory(by: categoryId) { categoryName in
            completion(categoryName)
        }
    }
    
    public func getEquipment(completion: @escaping ([String])-> Void ){
        let group = DispatchGroup()
        var equipmentNames:Array<String> = []
        for i in equipmen {
            group.enter()
            DataSource.retrieveEquipment(by: i) { equipmenName in
                equipmentNames.append(equipmenName)
                group.leave()
            }
        }
        group.notify(qos: DispatchQoS.default, flags: DispatchWorkItemFlags.assignCurrentContext, queue: DispatchQueue.main) {
            print("\n\n\n>>>> qos equipmentNames: \(equipmentNames) <<< \n\n\n")
        }
        completion(equipmentNames)
    }
    
    public func  getOtherInfo( completion: @escaping (String)-> Void) {
        self.getEquipment { [weak self] equipmentNames in
            let equipment = self?.generateEquipmentText(with: equipmentNames) ?? ""
            self?.getCategoryName { categoryName in
                DispatchQueue.main.async {
                    let text = "Category: " + categoryName + "\nEquipment: " + equipment
                    completion(text)
                }
            }
        }
    }
    
    private func generateEquipmentText(with equipmentNames:Array<String>) -> String {
        var equipment = ""
        var i = 0
        if equipmentNames.isEmpty {
            return "Unknow"
        }
        if equipmentNames.count == 1 {
            return equipmentNames[0]
        }
        for tool in equipmentNames {
            if i == equipmentNames.count - 1 {
                equipment = equipment + "and " + tool + "."
            } else {
                equipment = equipment +  tool + ", "
            }
            i += 1
        }
        return equipment
    }
    
    init(model:ExerciseModel) {
        self.model = model
    }
}

