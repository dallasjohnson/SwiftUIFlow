//
//  Flow2.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 01/09/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Combine
import Foundation

class ExampleFlow2: BaseFlow, Flow {
    func navigate(to destn: AppStep) -> AnyPublisher<FlowContributor, Never> {
        if let step = destn as? ExampleAppSteps {
            switch step {
                case .step1Flow2Required(let accountId):
                    return createFlow2SplashView(title: accountId)
                case .step2Flow2Required(let accountId):
                    return self.triggerDetailsDisplay(accountId: accountId)
                case .step2Required:
                    return Future({ promise in
                        let time = DispatchTime.now() + DispatchTimeInterval.milliseconds(2000)
                        DispatchQueue.main.asyncAfter(deadline: time) {
                            promise(.success(.pop(ainmated: true)))
                        }
                    }).eraseToAnyPublisher()
                //                return Just(.popToParentFlow(withStep: .step2Required(username: "coming back"))).eraseToAnyPublisher()
                default:
                    return Just(.none).eraseToAnyPublisher()
            }
        }

        return Just(FlowContributor.none).eraseToAnyPublisher()
    }
    
    func createFlow2SplashView(title: String) -> AnyPublisher<FlowContributor, Never> {
        let vm = Splash2ViewModel(title: title)
        return Just(.view(ViewPresentation(presentable: vm, type: .push))).eraseToAnyPublisher()
    }

    func triggerDetailsDisplay(accountId: String) -> AnyPublisher<FlowContributor, Never> {
        let vm2 = Flow1ViewModel2()
        return Just(.view(ViewPresentation(presentable: vm2, type: .push))).eraseToAnyPublisher()
    }
}
