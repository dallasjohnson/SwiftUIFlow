//
//  Flow2.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 01/09/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Combine
import Foundation

class ExampleFlow2: Flow {
    func navigate(to intent: Intent) -> AnyPublisher<FlowDriver, Never> {
        if let intent = intent as? ExampleAppIntents {
            switch intent {
                case .flow2InitialLaunch(let accountId):
                    return flow2Entry(accountId: accountId)
                case .flow2View1Requested(let username, let firstName):
                    return showView1(username: username,
                                          firstName: firstName)
                case .flow2View2Requested(let username, let firstName, let lastName):
                    return showView2(username: username,
                                          firstName: firstName,
                                          lastName: lastName)
                case .flow2Completed(let accountId):
                    return Future({ promise in
                        let time = DispatchTime.now() + DispatchTimeInterval.milliseconds(2000)
                        DispatchQueue.main.asyncAfter(deadline: time) {
                            promise(.success(.popToParentFlow(withIntent:
                                ExampleAppIntents.flow1View2Requested(accountId: accountId), animated: true)))
                        }
                    }).eraseToAnyPublisher()
                default:
                    return Just(.none).eraseToAnyPublisher()
            }
        }

        return Just(FlowDriver.none).eraseToAnyPublisher()
    }
    
    private func flow2Entry(accountId: String) -> AnyPublisher<FlowDriver, Never> {
        let vm = Flow2EntryViewModel(accountId: accountId)
        return Just(.view(vm, style: .push)).eraseToAnyPublisher()
    }

    private func showView1(username: String, firstName: String) -> AnyPublisher<FlowDriver, Never> {
        let vm = Flow2ViewModel1()
        return Just(.view(vm, style: .push)).eraseToAnyPublisher()
    }

    private func showView2(username: String, firstName: String, lastName: String) -> AnyPublisher<FlowDriver, Never> {
        let vm = Flow2ViewModel2()
        return Just(.view(vm, style: .push)).eraseToAnyPublisher()
    }
}
