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
        if let step = destn as? ExampleAppSteps {
            switch step {
                case .initialLaunch:
                    return createSplashView()
                case .step1Required:
                    return showView1()
                case .step2Required(let accountId):
                    return self.showView2(accountId: accountId)
                case .step3Required:
                    return Just(.pop(ainmated: true))
                        .eraseToAnyPublisher()
                case .step1Flow2Required(let accountId):
                    return Just(FlowContributor.contribute(withNextFlow: ExampleFlow2(),
                                                           startingStep: ExampleAppSteps.step1Flow2Required(accountId: accountId)))
                        .eraseToAnyPublisher()
                default:
                    return Just(FlowContributor.none)
                        .eraseToAnyPublisher()
            }
        }
            return Just(FlowContributor.none)
                .eraseToAnyPublisher()
    }

    private func createSplashView() -> AnyPublisher<FlowContributor, Never> {
        let vm = Flow1SplashViewModel()
        return Just(.view(ViewPresentation(presentable: vm,
                                           type: .root)))
            .eraseToAnyPublisher()
    }

    private func showView1() -> AnyPublisher<FlowContributor, Never> {
        let vm1 = Flow1ViewModel1()
        return Just(.view(ViewPresentation(presentable: vm1,
                                           type: .root)))
            .eraseToAnyPublisher()
    }

    private func showView2(accountId: String) -> AnyPublisher<FlowContributor, Never> {
        let vm2 = Flow1ViewModel2()
        return Just(.view(ViewPresentation(presentable: vm2,
                                           type: .modalWithPush)))
            .eraseToAnyPublisher()
    }

    private func showView3() -> AnyPublisher<FlowContributor, Never> {
        let vm3 = Flow1ViewModel3()
        return Just(.view(ViewPresentation(presentable: vm3,
                                           type: .push)))
            .eraseToAnyPublisher()
    }
}
