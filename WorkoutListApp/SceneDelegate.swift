//
//  SceneDelegate.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/9/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
      presentRootViewController(scene: scene)
    }
      
    func presentRootViewController(scene: UIScene) {
        DispatchQueue.main.async {
            if let windowScene = scene as? UIWindowScene {
                self.window = UIWindow(windowScene: windowScene)
                let rootVC = WorkoutListCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
                let navController = UINavigationController(rootViewController: rootVC)
                self.window?.rootViewController = navController
                self.window?.makeKeyAndVisible()
            }
        }
    }


}

