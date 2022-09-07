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
        
        let mockSlides = [
            Slide(title: "This is the best onboarding ever!",
                  content: "This onboarding is made of beautiful slides."),
            
            Slide(title: "When you slide, the background moves!",
                  content: "Isn't that the coolest thing ever?"),
            
            Slide(title: "The title shrinks as you slide away...",
                  content: "...and gets bigger as it slides in!"),
            
            Slide(title: "Follow my git to see how I did it!",
                  content: "Don't worry, if there're any questions, i'm happy to help."),
            
            Slide(title: "Press the button below...",
                  content: "...and make the magic happen!")
        ]
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = OnboardingViewController(with: mockSlides)
        window?.makeKeyAndVisible()
    }
}

