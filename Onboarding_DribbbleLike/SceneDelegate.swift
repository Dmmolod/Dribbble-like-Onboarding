//
//  SceneDelegate.swift
//  Onboarding_DribbbleLike
//
//  Created by Дмитрий Молодецкий on 06.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = OnboardingViewController()
        window?.makeKeyAndVisible()
    }
}

