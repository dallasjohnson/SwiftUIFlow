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
    private let navStateSubject = PassthroughSubject<NavigationState, Never>()
    var navStatePublisher: AnyPublisher<NavigationState, Never>
    private var cancellables = Set<AnyCancellable>()

    init() {
        navStatePublisher = navStateSubject.eraseToAnyPublisher()

        navStatePublisher.flatMap {
            $0.$isPresented
                .dropFirst()
                .removeDuplicates()
        }.sink {
            print("Didpop back: \($0)")
        }.store(in: &cancellables)
    }

    var startState: NavigationState {
        let navState = NavigationState(presentingStyle: PresentationStyle.push)
        let vm = ViewModel1(flow: self, navState: navState)
        let view = View1(viewModel: vm,
                         state: navState)
        navState.view = AnyView(view)
        return navState
    }

    func start() {
        navStateSubject.send(startState)
    }

    //    func navigate(to destn: AppSteps) -> FlowContributors {
    //        switch destn {
    //            case .initialLaunch:()
    //            case .loginRequired:()
    //            case .miRequired:()
    //            case .authenticated:()
    //            case .accountDetails(accountId: let accountId):()
    //
    //        }
    //        return FlowContributors.one(flowContributor:
    //            FlowContributor.contribute(withNextFlow: ExampleFlow2()))
    //    }

    func triggerDetailsDisplay(currentState: NavigationState) {
        let vm = ViewModel2()
        let view = View2(viewModel: vm, accountId: "Destination View")
        let navState = NavigationState(presentingStyle: .modal)
        navState.view = AnyView(view)
        navStateSubject.send(navState)
        currentState.destn = navState
        currentState.isPresented = true
    }
}
