//
//  Flow.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 24/07/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

protocol Presentable: class {
//    var destinationView: AnyView { get set }
}

protocol Flow {
    var navStatePublisher: AnyPublisher<NavigationState, Never> { get }
    var startState: NavigationState { get }
    func start()
//    func navigate(to destn: AppSteps) -> FlowContributors
}

enum FlowContributor {
    case contribute(withNextFlow: Flow, startingStep: AppSteps? = nil)
    /// the "withStep" step will be forwarded to the current flow
    case forwardToCurrentFlow(withStep: AppSteps)
    /// the "withStep" step will be forwarded to the parent flow
    case forwardToParentFlow(withStep: AppSteps)

}

enum FlowContributors {
    /// a Flow will trigger several FlowContributor at the same time for the same Step
    case multiple (flowContributors: [FlowContributor])
    /// a Flow will trigger only one FlowContributor for a Step
    case one (flowContributor: FlowContributor)
    /// no further navigation will be triggered for a Step
    case none
}

//protocol Step {
//    //    Usually an enum of potential steps
//}

// Often a ViewModel or a NavCoordinator
//protocol Stepper {
//    var nextStep: Step { get }
//}

// Examples -------------------------------------

enum AppSteps {
    case initialLaunch
    case loginRequired
    case miRequired
    case authenticated
    case accountDetails(accountId: String)
}

//class ExampleFlow2: Flow, ObservableObject {
//    var navNodePublisher: AnyPublisher<NavigationNode?, Never>
//
//    //    var newView = CurrentValueSubject<AnyView?, Error>(nil)
//
//    private let nodeSubject = PassthroughSubject<NavigationNode?, Never>()
//
//    init() {
//        navNodePublisher = nodeSubject.eraseToAnyPublisher()
//    }
//
//
//    func start() {
//        let vm = ViewModel2()
//        let node = NavigationNode.root(node:
//            NavigationState(viewModel: vm, viewCreator: {
//                return AnyView(View1(viewModel: $0 as! ViewModel1).environmentObject($1))
//            }))
//        nodeSubject.send(node)
//    }
//
//    func navigate(to destn: AppSteps) -> FlowContributors {
//        switch destn {
//            case .miRequired:()
//            case .authenticated:()
//            case .initialLaunch:()
//            case .loginRequired: ()
//            case .accountDetails(accountId: let accountId):
//                ()
//        }
//        return FlowContributors.one(flowContributor:
//            FlowContributor.contribute(withNextFlow: ExampleFlow1()))
//    }
//}

//struct Account {
//    var firstName: String
//    var lastName: String
//}

//class NavState: ObservableObject {
//    @Published var currentView: AnyView = AnyView(EmptyView())
//}

//indirect enum NavigationNode {
//    case root(navState: NavigationState)
//    case push(navState: NavigationState)
//    case modal(navState: NavigationState)
//    case tabs(navStates: [NavigationState])
//
//    func set(parent: NavigationNode) {
//        switch self {
//            case .root(navState: let state):
//                state.parentNode = parent
//            case .push(navState: let state):
//                state.parentNode = parent
//            case .modal(navState: let state):
//                state.parentNode = parent
//            case .tabs(navStates: let states):
//                states.forEach({ $0.parentNode = parent })
//        }
//    }
//
//    func add(child: NavigationNode) {
//        switch self {
//            case .root(navState: let navState):
//                navState.childNode = child
//            case .push(navState: let navState):
//                navState.childNode = child
//            case .modal(navState: let navState):
//                navState.childNode = child
//            case .tabs(navStates: let navStates):
//                navStates.forEach({ $0.childNode = child })
//        }
//    }
//}



