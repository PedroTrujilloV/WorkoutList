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
    
    private let urlString:String = "https://wger.de/api/v2/exercise/?format=json&language=2&limit=20&offset=40"//"https://wger.de/api/v2/exercise/?language=2&format=json"
    private let urlProcessingQueue = DispatchQueue(label: "urlProcessingQueue")
    private var _currentResult:Result?
    public var next:String {
        get{
            return currentResult?.next ?? "none"
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
    
    init(delegate:DataSourceDelegate) {
        guard let url = URL(string: urlString) else {print("\n ⚠️ DataSource.init(): There was a problem getting URL from: \(urlString)"); return}
        load(url: url)
        self.delegate = delegate
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
                    self?.dataSourceList = result.results.map({ExerciseViewModel(model: $0)})
                    self?.delegate?.dataSourceDidLoad(dataSource: self?.dataSourceList ?? [])
                }
            })
        
        self.cancellable?.cancel()
    }
    
    public static func retrieveImageModel(with id:Int, completion: @escaping (ImageModel) -> Void ) {
        let stringURL = "https://wger.de/api/v2/exerciseimage/\(id)/thumbnails/?is_main=True&language=2&format=json"
        guard let url = URL(string: stringURL) else { print("\n ⚠️ DataSource.retrieveThumbnailImageURLString(): There was a problem getting URL from: \(stringURL)")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("\n ⚠️ DataSource.retrieveThumbnailImageURLString() dataTask Error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("\n ⚠️ DataSource.retrieveThumbnailImageURLString() dataTask response: \(String(describing: response))")
                return
            }
            guard let data = data else { print("\n ⚠️ DataSource.retrieveThumbnailImageURLString() dataTask data error: \(String(describing: data))"); return }
            do {
                let imageModel = try JSONDecoder().decode(ImageModel.self, from: data)
                completion(imageModel)
            } catch let DecodingError.dataCorrupted(context) {
                print("\n ⚠️ dataCorrupted. Context:")
                print(context)
                completion(ImageModel(thumbnail: ThumbnailModel(url: "")) )
            } catch let DecodingError.keyNotFound(key, context) {
                print("\n ⚠️ Key '\(key)' not found:", context.debugDescription)
                print("\n codingPath:", context.codingPath)
                completion(ImageModel(thumbnail: ThumbnailModel(url: "")) )
            } catch let DecodingError.valueNotFound(value, context) {
                print("\n ⚠️ Value '\(value)' not found:", context.debugDescription)
                print("\n codingPath:", context.codingPath)
                completion(ImageModel(thumbnail: ThumbnailModel(url: "")) )
            } catch let DecodingError.typeMismatch(type, context)  {
                print("\n ⚠️ Type '\(type)' mismatch:", context.debugDescription)
                print("\n codingPath:", context.codingPath)
                completion(ImageModel(thumbnail: ThumbnailModel(url: "")) )
            } catch {
                print("\n ⚠️ error: ", error)
                completion(ImageModel(thumbnail: ThumbnailModel(url: "")) )
            }
        }
        task.resume()
    }
    
    deinit  {
        cancellable?.cancel()
    }
    
}
