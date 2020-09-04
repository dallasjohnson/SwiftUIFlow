//
//  Flow1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 07/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Combine
import SwiftUI

class ExampleFlow1: Flow {
    /// This fake var repesents some state that might change throughout the flow but between different that could effect the navigation flow.
    private var shouldLaunchFlow2 = false

    func navigate(to intent: Intent) -> AnyPublisher<FlowDriver, Never> {
//        This example is swtiching over the single Intent but there is no reason there couldn't be multiple Intent types that this method could branch through to suit the app's logic.
        if let intent = intent as? ExampleAppIntents {
            switch intent {
                case .initialLaunch:
                    return showSplash()
                case .flow1View1Requested:
                    return showView1()
                case .flow1View2Requested(let accountId):
                    return showView2(accountId: accountId)
                case .flow1View2Completed:
                    shouldLaunchFlow2 = true
                    return Just(.pop(animated: true))
                        .eraseToAnyPublisher()
                case .flow1RequestFlow2(let accountId):
                    return Just(FlowDriver.forwardToNewFlow(flow: ExampleFlow2(), intent:
                        ExampleAppIntents.flow2InitialLaunch(accountId: accountId)))
                        .eraseToAnyPublisher()
                default:
                    return Just(FlowDriver.none)
                        .eraseToAnyPublisher()
            }
        }
        return Just(FlowDriver.none)
            .eraseToAnyPublisher()
    }

    private func showSplash() -> AnyPublisher<FlowDriver, Never> {
        let vm = Flow1SplashViewModel()
        return Just(.view(vm,
                          style: .root))
            .eraseToAnyPublisher()
    }

    private func showView1() -> AnyPublisher<FlowDriver, Never> {
        let vm = Flow1ViewModel1()
        return Just(.view(vm,
                          style: .modalWithPush))
            .eraseToAnyPublisher()
    }

    private func showView2(accountId: String) -> AnyPublisher<FlowDriver, Never> {
        let vm = Flow1ViewModel2(shouldLaunchedFlow2: self.shouldLaunchFlow2)
        return Just(.view(vm,
                          style: .push))
            .eraseToAnyPublisher()
    }
}
