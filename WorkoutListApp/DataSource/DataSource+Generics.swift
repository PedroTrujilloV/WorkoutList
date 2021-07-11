//
//  DataSource+Generics.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/10/21.
//

import Foundation

extension DataSource {
    
    internal static func retrieve<T:Codable>(with id:Int,stringURL:String, completion: @escaping (T?) -> Void ) {
        guard let url = URL(string: stringURL) else { print("\n ⚠️ DataSource.retrieve(): There was a problem getting URL from: \(stringURL)")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("\n ⚠️ DataSource.retrieve() dataTask Error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("\n ⚠️ DataSource.retrieve() dataTask response: \(String(describing: response))")
                return
            }
            guard let data = data else { print("\n ⚠️ DataSource.retrieve() dataTask data error: \(String(describing: data))"); return }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(model)
            } catch let DecodingError.dataCorrupted(context) {
                print("\n ⚠️ dataCorrupted. Context:")
                print(context)
                completion(nil)
            } catch let DecodingError.keyNotFound(key, context) {
                print("\n ⚠️ Key '\(key)' not found:", context.debugDescription)
                print("\n codingPath:", context.codingPath)
                completion(nil)
            } catch let DecodingError.valueNotFound(value, context) {
                print("\n ⚠️ Value '\(value)' not found:", context.debugDescription)
                print("\n codingPath:", context.codingPath)
                completion(nil)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("\n ⚠️ Type '\(type)' mismatch:", context.debugDescription)
                print("\n codingPath:", context.codingPath)
                completion(nil)
            } catch {
                print("\n ⚠️ error: ", error)
                completion(nil)
            }
        }
        task.resume()
    }
    
}
