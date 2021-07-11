//
//  DataSource.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/9/21.
//

import Foundation


import Foundation
import Combine


protocol DataSourceDelegate:AnyObject {
    func dataSourceDidLoad(dataSource:Array<ExerciseViewModel>)
}

class DataSource {
    
    private let urlString:String = "https://wger.de/api/v2/exercise/?language=2&format=json"
    private let urlProcessingQueue = DispatchQueue(label: "urlProcessingQueue")
    private var _currentResult:Result?
    public var next:String {
        get{
            return currentResult?.next ?? "none"
        }
    }
    public var totalItems: Int {
        get {
            return currentResult?.count ?? 0
        }
    }
    public var currentResult:Result? {
        get {
            return _currentResult
        }
    }
    private var cancellable: AnyCancellable?
    private weak var delegate:DataSourceDelegate?
    private var dataSourceList:Array<ExerciseViewModel> = []
    private static var _categories:Dictionary<Int,String> = [:]
    
    
    init(delegate:DataSourceDelegate) {
        guard let url = URL(string: urlString) else {print("\n ⚠️ DataSource.init(): There was a problem getting URL from: \(urlString)"); return}
        load(url: url)
        self.delegate = delegate
        DataSource.retrieveCategory(nil)
    }
    
    public func loadNext(){
        guard let nextString = currentResult?.next else { print("\n ⚠️ DataSource.loadNext(): There was a problem getting string from: currentResult.next "); return }
        guard let url = URL(string: nextString) else { print("\n ⚠️ DataSource.loadNext(): There was a problem getting URL from: \(nextString)"); return }
        self.load(url: url)
    }
    
    private func load(url:URL) {
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: urlProcessingQueue)
            .receive(on:DispatchQueue.main)
            .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                return element.data
            }
            .decode(type: Result.self, decoder: JSONDecoder() )
            .eraseToAnyPublisher()
            .sink(receiveCompletion: {completion in
                print("Received completion: \(completion).")
                switch completion {
                case .finished:
                    print("JSON loaded!")
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }, receiveValue: { [weak self]  result in
                DispatchQueue.main.async { [weak self] in
                    self?._currentResult = result
                    let results = result.results.map({ExerciseViewModel(model: $0)})
                    self?.dataSourceList.append(contentsOf: results)
                    self?.delegate?.dataSourceDidLoad(dataSource: self?.dataSourceList ?? [])
                }
            })
        
        self.cancellable?.cancel()
    }
    
    public static func retrieveImageModel(with id:Int, completion: @escaping (ImageModel?) -> Void ) {
        let stringURL = "https://wger.de/api/v2/exerciseimage/\(id)/thumbnails/?is_main=True&language=2&format=json"
        DataSource.retrieve(with: id, stringURL: stringURL, completion: completion)
    }
    
    public static func retrieveCategory(by id:Int = -1,_ completion: ( (String)->Void )? ){
        if let category = DataSource._categories[id] {
            if let completion = completion {
                completion(category)
            }
        } else {
            let stringURL = "https://wger.de/api/v2/exercisecategory/?format=json"
            let completionHandler: (CategoryResult?)->Void = { result in
                let results = result?.results
                let categoryDictionary = results?.reduce([Int: String]()) { (dict, category) -> [Int: String] in
                    var dict = dict
                    dict[category.id] = category.name
                    return dict
                }
                if let categoryDictionary = categoryDictionary {
                    DataSource._categories = categoryDictionary
                    if let categoryName = DataSource._categories[id] {
                        if let completion = completion {
                            completion(categoryName)
                        }
                    }
                }
            }
            DataSource.retrieve(with: id, stringURL: stringURL, completion: completionHandler)
        }
    }
    
    
    deinit  {
        cancellable?.cancel()
    }
    
    
}
