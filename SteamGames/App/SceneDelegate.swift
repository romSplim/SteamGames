//
//  SceneDelegate.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        let builder = ModuleBuilder()
        let router = Router(navigationController: navigationController, builder: builder)
        
        router.initialController()
        
        let testView = DetailArticleView()
        
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
