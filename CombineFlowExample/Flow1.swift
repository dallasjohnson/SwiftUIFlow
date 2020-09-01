//
//  Flow1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 07/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Combine
import SwiftUI

class ExampleFlow1: BaseFlow, Flow {
    func navigate(to destn: AppStep) -> AnyPublisher<FlowContributor, Never> {
        switch destn {
            case .initialLaunch:
                return createSplashView()
            case .step1Required:
                return start()
            case .step2Required(let accountId):
                return self.triggerDetailsDisplay(accountId: accountId)
            case .step3Required:
                return Just(.pop(ainmated: true)).eraseToAnyPublisher()
            case .step1Flow2Required(let accountId):
                return Just(FlowContributor.contribute(withNextFlow: ExampleFlow2(),
                    startingStep: AppStep.step1Flow2Required(accountId: accountId))).eraseToAnyPublisher()
            default:
                return Just(FlowContributor.none).eraseToAnyPublisher()
        }
    }

    func createSplashView() -> AnyPublisher<FlowContributor, Never> {
        let vm = SplashViewModel()
        return Just(.view(ViewPresentation(presentable: vm, type: .root))).eraseToAnyPublisher()
    }

    func start() -> AnyPublisher<FlowContributor, Never> {
        let vm1 = ViewModel1()
        return Just(.view(ViewPresentation(presentable: vm1, type: .root))).eraseToAnyPublisher()
    }

    func triggerDetailsDisplay(accountId: String) -> AnyPublisher<FlowContributor, Never> {
        let vm2 = ViewModel2()
        return Just(.view(ViewPresentation(presentable: vm2, type: .modalWithPush))).eraseToAnyPublisher()
    }

    func triggerSecondDetailsDisplay() -> AnyPublisher<FlowContributor, Never> {
        let vm3 = ViewModel3()
        return Just(.view(ViewPresentation(presentable: vm3, type: .push))).eraseToAnyPublisher()
    }
}

class ExampleFlow2: BaseFlow, Flow {
    func navigate(to destn: AppStep) -> AnyPublisher<FlowContributor, Never> {
        switch destn {
            case .step1Flow2Required(let accountId):
                return createFlow2SplashView(title: accountId)
            case .step2Flow2Required(let accountId):
                return self.triggerDetailsDisplay(accountId: accountId)
            case .step2Required:
                return Just(.pop(ainmated: true)).eraseToAnyPublisher()
//                return Just(.popToParentFlow(withStep: .step2Required(username: "coming back"))).eraseToAnyPublisher()
            default:
                return Just(.none).eraseToAnyPublisher()
        }
    }

    func createFlow2SplashView(title: String) -> AnyPublisher<FlowContributor, Never> {
        let vm = Splash2ViewModel(title: title)
        return Just(.view(ViewPresentation(presentable: vm, type: .push))).eraseToAnyPublisher()
    }

    func triggerDetailsDisplay(accountId: String) -> AnyPublisher<FlowContributor, Never> {
        let vm2 = ViewModel2()
        return Just(.view(ViewPresentation(presentable: vm2, type: .push))).eraseToAnyPublisher()
    }
}
