//
//  ImageLoader.swift
//  WorkoutListApp
//
//  Created by Pedro Trujillo on 1/6/21.
//

import Foundation
import UIKit.UIImage
import Combine

public final class ImageLoader {
    public static let shared = ImageLoader()

    private let cache: ImageCacheType
    private let imageProcessingQueue = DispatchQueue(label: "imageProcessingQueue")


    public init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }

    public func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .print("Image loading \(url):")
            .subscribe(on: imageProcessingQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
