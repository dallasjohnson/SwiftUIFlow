//
//  SceneDelegate.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 24/07/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: TabBarNavCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        //        let contentView = View1(accountId: "sdfsdfsdf")

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            coordinator = TabBarNavCoordinator(window: window)
            let flow1 = ExampleFlow1()
            let flow2 = ExampleFlow1()
            let flow3 = ExampleFlow1()
            let flow4 = ExampleFlow1()
            let flow5 = ExampleFlow1()
            let flow6 = ExampleFlow1()

            let tItem1 = UITabBarItem(title: "First", image: nil, selectedImage: nil)
            let tItem2 = UITabBarItem(title: "Second", image: nil, selectedImage: nil)
            let tItem3 = UITabBarItem(title: "Third", image: nil, selectedImage: nil)
            let tItem4 = UITabBarItem(title: "Forth", image: nil, selectedImage: nil)
            let tItem5 = UITabBarItem(title: "Fifth", image: nil, selectedImage: nil)
            let tItem6 = UITabBarItem(title: "Sixth", image: nil, selectedImage: nil)
            coordinator?.startFlows(flowContributors:
                [(tItem1, .contribute(withNextFlow: flow1,
                                      startingStep: AppStep.step1Required)),
                 (tItem2, .contribute(withNextFlow: flow2,
                                      startingStep: AppStep.initialLaunch)),
                 (tItem3, .contribute(withNextFlow: flow3,
                                      startingStep: AppStep.step2Required(username: "username"))),
                 (tItem4, .contribute(withNextFlow: flow4,
                                      startingStep: AppStep.initialLaunch)),
                 (tItem5, .contribute(withNextFlow: flow5,
                                      startingStep: AppStep.step1Required)),
                 (tItem6, .contribute(withNextFlow: flow6,
                                      startingStep: AppStep.initialLaunch))
            ])
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

