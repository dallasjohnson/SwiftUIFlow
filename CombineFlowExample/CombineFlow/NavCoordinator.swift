//
//  NavCoordinator.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 28/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Foundation
import UIKit

class BaseNavCoordinator {
    private var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
}

class MasterDetailCoordinator: BaseNavCoordinator {
    var flowCoordinator = FlowCoordinator()

    override init(window: UIWindow) {
        super.init(window: window)
        window.rootViewController = flowCoordinator.rootNavigationController
        window.makeKeyAndVisible()
    }
}

class TabBarNavCoordinator: BaseNavCoordinator {
    var flowCoordinators: [FlowCoordinator] = [] {
        didSet {
            self.tabBarController.setViewControllers(flowCoordinators.map { $0.rootNavigationController },
                                                     animated: false)
        }
    }
    private var tabBarController = UITabBarController()

    override init(window: UIWindow) {
        super.init(window: window)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func startFlows(flowContributors: [(UITabBarItem, FlowDriver)]) {
        var flowCoords = [FlowCoordinator]()
        for (tabBarItem, flowContributor) in flowContributors {
            let f = FlowCoordinator()
            f.flowContributor = flowContributor
            let rootVC = f.rootNavigationController
            rootVC.tabBarItem = tabBarItem
            flowCoords.append(f)
        }

        self.flowCoordinators = flowCoords
    }
}

//TODO: To be built out
class SplitViewNavCoordinator: BaseNavCoordinator {
    var primary = FlowCoordinator()
    var secondary = FlowCoordinator()
}
