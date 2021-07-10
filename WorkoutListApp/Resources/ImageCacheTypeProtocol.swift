//
//  ImageCacheTypeProtocol.swift
//  IbottaiOSMobileDevTest
//  Reference: https://github.com/sgl0v/OnSwiftWings
//  Created by Maksym Shcheglov, edited by Pedro Trujillo on 8/25/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import UIKit.UIImage
import Combine

// Declares in-memory image cache
public protocol ImageCacheType: class {
    // Returns the image associated with a given url
    func image(for url: URL) -> UIImage?
    // Inserts the image of the specified url in the cache
    func insertImage(_ image: UIImage?, for url: URL)
    // Removes the image of the specified url in the cache
    func removeImage(for url: URL)
    // Removes all images from the cache
    func removeAllImages()
    // Accesses the value associated with the given key for reading and writing
    subscript(_ url: URL) -> UIImage? { get set }
}
